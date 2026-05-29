import 'package:flutter/material.dart';

class IngredientDef {
  const IngredientDef(this.label, this.key, this.icon, this.category);
  final String label;
  final String key;
  final IconData icon;
  final String category;
}

const ingredientCategories = ['Semua', 'Protein', 'Sayur', 'Bumbu', 'Karbohidrat'];

const ingredientCatalog = <IngredientDef>[
  IngredientDef('Telur', 'telur', Icons.egg_rounded, 'Protein'),
  IngredientDef('Ikan', 'ikan', Icons.set_meal_rounded, 'Protein'),
  IngredientDef('Ayam', 'ayam', Icons.kebab_dining_rounded, 'Protein'),
  IngredientDef('Tahu', 'tahu', Icons.lunch_dining_rounded, 'Protein'),
  IngredientDef('Tempe', 'tempe', Icons.bakery_dining_rounded, 'Protein'),
  IngredientDef('Sawi', 'sawi hijau', Icons.eco_rounded, 'Sayur'),
  IngredientDef('Kangkung', 'kangkung', Icons.eco_rounded, 'Sayur'),
  IngredientDef('Wortel', 'wortel', Icons.local_florist_rounded, 'Sayur'),
  IngredientDef('Tomat', 'tomat', Icons.circle_rounded, 'Sayur'),
  IngredientDef('Daun Bawang', 'daun bawang', Icons.spa_rounded, 'Sayur'),
  IngredientDef('Bawang Merah', 'bawang merah', Icons.grass_rounded, 'Bumbu'),
  IngredientDef('Bawang Putih', 'bawang putih', Icons.grass_rounded, 'Bumbu'),
  IngredientDef('Cabai', 'cabai rawit', Icons.local_fire_department_rounded, 'Bumbu'),
  IngredientDef('Cabai Merah', 'cabai merah', Icons.local_fire_department_rounded, 'Bumbu'),
  IngredientDef('Kecap', 'kecap', Icons.water_drop_rounded, 'Bumbu'),
  IngredientDef('Nasi', 'nasi', Icons.rice_bowl_rounded, 'Karbohidrat'),
  IngredientDef('Beras', 'beras', Icons.rice_bowl_rounded, 'Karbohidrat'),
  IngredientDef('Mie', 'mie instan', Icons.ramen_dining_rounded, 'Karbohidrat'),
  IngredientDef('Roti', 'roti tawar', Icons.cookie_rounded, 'Karbohidrat'),
];

IngredientDef? findIngredientByKey(String key) {
  for (final i in ingredientCatalog) {
    if (i.key == key) return i;
  }
  return null;
}
