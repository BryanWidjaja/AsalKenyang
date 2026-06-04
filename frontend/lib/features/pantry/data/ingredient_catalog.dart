import 'package:flutter/material.dart';

import '../../../shared/utils/ingredient_groups.dart';

class IngredientDef {
  const IngredientDef(
    this.label,
    this.key,
    this.icon,
    this.category,
    this.defaultQuantity,
  );

  final String label;
  final String key;
  final IconData icon;
  final String category;
  final String defaultQuantity;
}

const ingredientCategories = [
  'Semua',
  'Protein',
  'Sayur',
  'Bumbu',
  'Karbohidrat',
];

const ingredientCatalog = <IngredientDef>[
  IngredientDef('Telur', 'telur', Icons.egg_rounded, 'Protein', '1 butir'),
  IngredientDef('Ikan', 'ikan', Icons.set_meal_rounded, 'Protein', '1 ekor'),
  IngredientDef(
    'Ayam',
    'ayam',
    Icons.kebab_dining_rounded,
    'Protein',
    '1 potong',
  ),
  IngredientDef('Tahu', 'tahu', Icons.rectangle, 'Protein', '1 buah'),
  IngredientDef(
    'Tempe',
    'tempe',
    Icons.bakery_dining_rounded,
    'Protein',
    '1 papan',
  ),
  IngredientDef('Sawi', 'sawi hijau', Icons.eco_rounded, 'Sayur', '1 ikat'),
  IngredientDef('Kangkung', 'kangkung', Icons.eco_rounded, 'Sayur', '1 ikat'),
  IngredientDef('Wortel', 'wortel', Icons.eco_rounded, 'Sayur', '1 buah'),
  IngredientDef('Tomat', 'tomat', Icons.circle_rounded, 'Sayur', '1 buah'),
  IngredientDef(
    'Daun Bawang',
    'daun bawang',
    Icons.spa_rounded,
    'Sayur',
    '1 batang',
  ),
  IngredientDef(
    'Bawang Merah',
    'bawang merah',
    Icons.grass_rounded,
    'Bumbu',
    '1 siung',
  ),
  IngredientDef(
    'Bawang Putih',
    'bawang putih',
    Icons.grass_rounded,
    'Bumbu',
    '1 siung',
  ),
  IngredientDef(
    'Cabai',
    'cabai',
    Icons.local_fire_department_rounded,
    'Bumbu',
    '1 buah',
  ),
  IngredientDef('Kecap', 'kecap', Icons.water_drop_rounded, 'Bumbu', '1 sdm'),
  IngredientDef('Garam', 'garam', Icons.grain_rounded, 'Bumbu', '1 sdt'),
  IngredientDef(
    'Nasi',
    'nasi',
    Icons.rice_bowl_rounded,
    'Karbohidrat',
    '1 piring',
  ),
  IngredientDef(
    'Mie',
    'mie instan',
    Icons.ramen_dining_rounded,
    'Karbohidrat',
    '1 bungkus',
  ),
  IngredientDef(
    'Roti',
    'roti tawar',
    Icons.cookie_rounded,
    'Karbohidrat',
    '1 lembar',
  ),
];

IngredientDef? findIngredientByKey(String key) {
  for (final i in ingredientCatalog) {
    if (i.key == key) return i;
  }
  return null;
}

String defaultQuantityForIngredient(String key) {
  final def = findIngredientByKey(key);
  if (def != null) return def.defaultQuantity;

  final lower = key.toLowerCase();
  if (lower.contains('telur')) return '1 butir';
  if (isFishIngredient(key)) return '1 ekor';
  if (lower.contains('ayam')) return '1 potong';
  if (lower.contains('tahu')) return '1 buah';
  if (lower.contains('tempe')) return '1 papan';
  if (lower.contains('bawang merah') || lower.contains('bawang putih')) {
    return '1 siung';
  }
  if (lower.contains('cabai') || lower.contains('cabe')) return '1 buah';
  if (lower.contains('garam')) return '1 sdt';
  if (lower.contains('daun bawang')) return '1 batang';
  if (lower.contains('daun')) return '1 lembar';
  if (lower.contains('kangkung') || lower.contains('sawi')) return '1 ikat';
  if (lower.contains('wortel') || lower.contains('tomat')) return '1 buah';
  if (lower.contains('nasi') || lower.contains('beras')) return '1 piring';
  if (lower.contains('mie')) return '1 bungkus';
  if (lower.contains('roti')) return '1 lembar';
  if (lower.contains('kecap') ||
      lower.contains('saus') ||
      lower.contains('minyak')) {
    return '1 sdm';
  }
  return '1';
}
