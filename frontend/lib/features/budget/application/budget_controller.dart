import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/budget_models.dart';
import '../data/budget_repository.dart';

class BudgetState {
  const BudgetState({
    this.wallet,
    this.spendings = const [],
    this.isLoading = false,
  });

  final Wallet? wallet;
  final List<Spending> spendings;
  final bool isLoading;

  int get totalSpendings {
    // In a real app, filter by current month/startDay. For MVP, sum all.
    return spendings.fold(0, (sum, item) => sum + item.amount);
  }

  int get remainingBudget {
    if (wallet == null) return 0;
    return wallet!.totalBudget - totalSpendings;
  }

  double get remainingPercent {
    if (wallet == null || wallet!.totalBudget == 0) return 0;
    return (remainingBudget / wallet!.totalBudget).clamp(0, 1).toDouble();
  }

  BudgetState copyWith({
    Wallet? wallet,
    List<Spending>? spendings,
    bool? isLoading,
  }) {
    return BudgetState(
      wallet: wallet ?? this.wallet,
      spendings: spendings ?? this.spendings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final budgetControllerProvider =
    NotifierProvider<BudgetController, BudgetState>(BudgetController.new);

class BudgetController extends Notifier<BudgetState> {
  @override
  BudgetState build() {
    Future.microtask(() {
      loadLocal();
      refreshRemote();
    });
    return const BudgetState();
  }

  Future<void> loadLocal() async {
    state = state.copyWith(isLoading: true);
    final repository = ref.read(budgetRepositoryProvider);
    final wallet = await repository.getLocalWallet();
    final spendings = await repository.getLocalSpendings();
    state = state.copyWith(
      wallet: wallet,
      spendings: spendings,
      isLoading: false,
    );
  }

  Future<void> refreshRemote() async {
    final repository = ref.read(budgetRepositoryProvider);
    await repository.refreshWallet();
    await repository.refreshSpendings();
    await loadLocal();
  }

  Future<void> updateBudget(int total) async {
    final repository = ref.read(budgetRepositoryProvider);
    await repository.updateBudget(total);
    await loadLocal();
  }

  Future<void> addSpending(int amount, String title, List<String> tags) async {
    final repository = ref.read(budgetRepositoryProvider);
    await repository.addSpending(amount, title, tags);
    await loadLocal();
  }
}
