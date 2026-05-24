import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_page.dart';
import 'features/auth/presentation/register_page.dart';
import 'features/auth/presentation/splash_page.dart';
import 'features/budget/presentation/spending_history_page.dart';
import 'features/recipes/presentation/favorites_page.dart';
import 'features/recipes/presentation/recipe_detail_page.dart';
import 'features/recipes/presentation/search_results_page.dart';
import 'features/shell/presentation/home_shell.dart';

void main() {
  runApp(const AsalKenyangApp());
}

class AsalKenyangApp extends StatelessWidget {
  const AsalKenyangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsalKenyang',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (_) => const SplashPage(),
        LoginPage.route: (_) => const LoginPage(),
        RegisterPage.route: (_) => const RegisterPage(),
        HomeShell.route: (_) => const HomeShell(),
        SearchResultsPage.route: (_) => const SearchResultsPage(),
        FavoritesPage.route: (_) => const FavoritesPage(),
        RecipeDetailPage.route: (_) => const RecipeDetailPage(),
        SpendingHistoryPage.route: (_) => const SpendingHistoryPage(),
      },
    );
  }
}
