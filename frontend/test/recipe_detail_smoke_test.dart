import 'package:asalkenyang/core/theme/app_theme.dart';
import 'package:asalkenyang/features/recipes/data/recipe_models.dart';
import 'package:asalkenyang/features/recipes/presentation/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RecipeDetailPage renders body content', (tester) async {
    const recipe = Recipe(
      id: 'test-recipe',
      name: 'Nasi Goreng Kosan',
      kategori: 'nasi',
      porsi: 1,
      estPrice: 5000,
      estCalories: 400,
      cookTime: 15,
      imageUrl: '',
      alat: ['kompor'],
      bahan: [
        Bahan(nama: 'nasi', jumlah: '1 piring', harga: 3000, key: 'nasi'),
      ],
      bahanKey: ['nasi'],
      langkah: ['Tumis bumbu, masukkan nasi, lalu aduk rata.'],
      tags: ['murah'],
      halal: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            settings: const RouteSettings(arguments: recipe),
            builder: (_) => const RecipeDetailPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nasi Goreng Kosan'), findsOneWidget);
    expect(find.text('400 kkal/porsi'), findsOneWidget);
    expect(find.text('Bahan-bahan'), findsOneWidget);
    expect(find.text('Cara Memasak'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
