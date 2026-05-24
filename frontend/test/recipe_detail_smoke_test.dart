import 'package:asalkenyang/core/theme/app_theme.dart';
import 'package:asalkenyang/features/recipes/presentation/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RecipeDetailPage renders body content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const RecipeDetailPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sayur Lodeh Tanggal Tua'), findsOneWidget);
    expect(find.text('Bahan-bahan'), findsOneWidget);
    expect(find.text('Cara Memasak'), findsOneWidget);
  });
}
