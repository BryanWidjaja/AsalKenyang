import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../budget/presentation/profile_page.dart';
import '../../grocery/presentation/grocery_page.dart';
import '../../pantry/presentation/cook_page.dart';
import '../../plan/presentation/meal_plan_page.dart';
import '../../recipes/presentation/recipe_browse_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  static const String route = '/home';

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    CookPage(),
    RecipeBrowsePage(),
    MealPlanPage(),
    GroceryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: BottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
