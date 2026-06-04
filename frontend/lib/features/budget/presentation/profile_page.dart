import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/budget_hero_card.dart';
import '../../../shared/widgets/profile_header_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/settings_tile.dart';
import '../../../shared/widgets/spending_history_row.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/presentation/login_page.dart';
import '../../recipes/presentation/favorites_page.dart';
import '../application/budget_controller.dart';
import 'about_page.dart';
import 'spending_history_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? _displayName;
  String _role = 'Mahasiswa Kost';

  @override
  Widget build(BuildContext context) {
    final budgetState = ref.watch(budgetControllerProvider);
    final user = ref.watch(authControllerProvider).value;
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final fallbackName = user?.email ?? 'Pengguna AsalKenyang';
    final profileName = (_displayName?.trim().isNotEmpty ?? false)
        ? _displayName!.trim()
        : fallbackName;

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.shell(
        budgetText: fmt.format(budgetState.remainingBudget),
        onBudgetTap: () => _showBudgetDialog(
          context,
          ref,
          budgetState.wallet?.totalBudget ?? 0,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.screenMaxWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.lg,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: [
                ProfileHeaderCard(
                  name: profileName,
                  role: _role,
                  onEdit: () => _showProfileDialog(
                    context,
                    currentName: profileName,
                    currentRole: _role,
                    onSave: (name, role) {
                      setState(() {
                        _displayName = name;
                        _role = role;
                      });
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                BudgetHeroCard(
                  sisaText: fmt.format(budgetState.remainingBudget),
                  terpakaiText: fmt.format(budgetState.totalSpendings),
                  totalText: fmt.format(budgetState.wallet?.totalBudget ?? 0),
                  remainingPercent: budgetState.remainingPercent,
                  remainingLabel:
                      '${(budgetState.remainingPercent * 100).toStringAsFixed(0)}% Tersisa',
                  onAturAnggaran: () => _showBudgetDialog(
                    context,
                    ref,
                    budgetState.wallet?.totalBudget ?? 0,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Pengaturan'),
                const SizedBox(height: AppSpacing.md),
                _SettingsGrid(
                  onResepDisukai: () =>
                      Navigator.of(context).pushNamed(FavoritesPage.route),
                ),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(
                  title: 'Riwayat Belanja',
                  actionLabel: 'Lihat Semua',
                  onAction: () => Navigator.of(
                    context,
                  ).pushNamed(SpendingHistoryPage.route),
                ),
                const SizedBox(height: AppSpacing.md),
                if (budgetState.spendings.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Text(
                      'Belum ada pengeluaran.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                for (final s in budgetState.spendings.take(3)) ...[
                  SpendingHistoryRow(
                    title: s.title,
                    subtitle: DateFormat('dd MMM yyyy').format(s.date),
                    amount: '- ${fmt.format(s.amount)}',
                    icon: Icons.receipt_long_rounded,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                const SizedBox(height: AppSpacing.lg),
                TextButton(
                  onPressed: () async {
                    await ref.read(authControllerProvider.notifier).logout();
                    if (!context.mounted) return;
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(LoginPage.route, (_) => false);
                  },
                  child: Text(
                    'Keluar',
                    style: AppTypography.label.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showBudgetDialog(BuildContext context, WidgetRef ref, int currentBudget) {
  final inputFormatter = _RupiahInputFormatter();
  final controller = TextEditingController(
    text: currentBudget > 0 ? inputFormatter.formatInt(currentBudget) : '',
  );

  showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Atur Anggaran'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            inputFormatter,
          ],
          decoration: const InputDecoration(
            labelText: 'Anggaran bulanan',
            prefixText: 'Rp ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () async {
              final value = int.tryParse(
                controller.text.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              if (value == null || value <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Masukkan nominal anggaran yang valid.'),
                  ),
                );
                return;
              }
              try {
                await ref
                    .read(budgetControllerProvider.notifier)
                    .updateBudget(value);
                if (ctx.mounted) Navigator.pop(ctx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Anggaran berhasil diperbarui.'),
                    ),
                  );
                }
              } catch (_) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gagal menyimpan anggaran. Coba lagi.'),
                  ),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  ).whenComplete(controller.dispose);
}

class _RupiahInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id_ID');

  String formatInt(int value) => _formatter.format(value);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return const TextEditingValue();

    final number = int.parse(digits);
    final formatted = formatInt(number);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

void _showProfileDialog(
  BuildContext context, {
  required String currentName,
  required String currentRole,
  required void Function(String name, String role) onSave,
}) {
  final nameController = TextEditingController(text: currentName);
  final roleController = TextEditingController(text: currentRole);

  showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nama tampilan'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Peran'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final role = roleController.text.trim();
              if (name.isEmpty || role.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nama dan peran tidak boleh kosong.'),
                  ),
                );
                return;
              }
              onSave(name, role);
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  ).whenComplete(() {
    nameController.dispose();
    roleController.dispose();
  });
}

class _SettingsGrid extends StatelessWidget {
  const _SettingsGrid({required this.onResepDisukai});

  final VoidCallback onResepDisukai;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.sm;
        final colWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.favorite_rounded,
                label: 'Resep Disukai',
                onTap: onResepDisukai,
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.kitchen_rounded,
                label: 'Bahan Tersimpan',
                onTap: () => Navigator.of(context).pushNamed('/pantry-saved'),
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.notifications_rounded,
                label: 'Notifikasi',
                onTap: () => Navigator.of(context).pushNamed('/notifications'),
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.info_rounded,
                label: 'Tentang Aplikasi',
                onTap: () => Navigator.of(context).pushNamed(AboutPage.route),
              ),
            ),
          ],
        );
      },
    );
  }
}
