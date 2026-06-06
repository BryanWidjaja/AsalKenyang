import 'package:asalkenyang/features/recipes/data/recipe_models.dart';
import 'package:asalkenyang/features/recipes/domain/recipe_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generic ikan pantry key matches fish-specific recipe keys', () {
    final results = matchRecipes(
      allRecipes: [
        _recipe(
          id: 'ikan-peda',
          name: 'Ikan Peda Goreng',
          bahanKey: ['ikan peda', 'tepung'],
        ),
        _recipe(
          id: 'teri',
          name: 'Teri Balado',
          bahanKey: ['teri', 'cabai merah'],
        ),
        _recipe(id: 'ayam', name: 'Ayam Goreng', bahanKey: ['ayam']),
      ],
      pantryKeys: ['ikan'],
      sortDesc: false,
    );

    expect(results.map((matched) => matched.recipe.id), containsAll(['ikan-peda', 'teri']));
    expect(results.map((matched) => matched.recipe.id), isNot(contains('ayam')));

    final peda = results.singleWhere((matched) => matched.recipe.id == 'ikan-peda');
    expect(peda.matchedKeys, contains('ikan peda'));
    expect(peda.missingKeys, isNot(contains('ikan peda')));
  });

  test('generic cabai and nasi keys match old variant keys', () {
    final results = matchRecipes(
      allRecipes: [
        _recipe(id: 'sambal', name: 'Sambal', bahanKey: ['cabai', 'nasi']),
        _recipe(id: 'ayam', name: 'Ayam Goreng', bahanKey: ['ayam']),
      ],
      pantryKeys: ['cabai rawit', 'beras'],
      sortDesc: false,
    );

    expect(results.map((matched) => matched.recipe.id), contains('sambal'));
    final sambal = results.singleWhere((matched) => matched.recipe.id == 'sambal');
    expect(sambal.matchedKeys, containsAll(['cabai', 'nasi']));
    expect(sambal.missingKeys, isNot(contains('cabai')));
    expect(sambal.missingKeys, isNot(contains('nasi')));
  });
}

Recipe _recipe({
  required String id,
  required String name,
  required List<String> bahanKey,
}) {
  return Recipe(
    id: id,
    name: name,
    kategori: 'ikan',
    porsi: 2,
    estPrice: 10000,
    estCalories: 300,
    cookTime: 15,
    imageUrl: '',
    alat: const [],
    bahan: bahanKey
        .map((key) => Bahan(nama: key, jumlah: '1', harga: 1000, key: key))
        .toList(),
    bahanKey: bahanKey,
    langkah: const ['Masak sampai matang.'],
    tags: const [],
    halal: true,
  );
}
