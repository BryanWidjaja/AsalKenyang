const _fishTerms = {
  'ikan',
  'ikan asin',
  'ikan peda',
  'peda',
  'ikan tongkol',
  'tongkol',
  'ikan kembung',
  'kembung',
  'teri',
  'ikan teri',
  'ikan bilis',
  'bilis',
  'tuna',
  'tenggiri',
  'lele',
  'nila',
  'mujair',
  'cakalang',
  'bandeng',
  'patin',
  'gurame',
  'dori',
  'bawal',
  'layur',
};

const _chiliTerms = {
  'cabai',
  'cabe',
  'cabai rawit',
  'cabe rawit',
  'cabai merah',
  'cabe merah',
  'cabai hijau',
  'cabe hijau',
  'cabe ijo',
};

const _riceTerms = {'nasi', 'nasi putih', 'beras'};

String normalizeIngredientKey(String key) {
  return key
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');
}

bool isFishIngredient(String key) {
  final normalized = normalizeIngredientKey(key);
  if (normalized.isEmpty) return false;

  return _fishTerms.any((term) {
    return normalized == term ||
        normalized.startsWith('$term ') ||
        normalized.endsWith(' $term') ||
        normalized.contains(' $term ');
  });
}

bool isGenericFishIngredient(String key) {
  return normalizeIngredientKey(key) == 'ikan';
}

bool isChiliIngredient(String key) {
  final normalized = normalizeIngredientKey(key);
  if (normalized.isEmpty) return false;

  return _chiliTerms.any((term) {
    return normalized == term ||
        normalized.startsWith('$term ') ||
        normalized.endsWith(' $term') ||
        normalized.contains(' $term ');
  });
}

bool isRiceIngredient(String key) {
  final normalized = normalizeIngredientKey(key);
  if (normalized.isEmpty) return false;

  return _riceTerms.any((term) {
    return normalized == term ||
        normalized.startsWith('$term ') ||
        normalized.endsWith(' $term') ||
        normalized.contains(' $term ');
  });
}

bool ingredientKeysMatch(String availableKey, String requiredKey) {
  final available = normalizeIngredientKey(availableKey);
  final required = normalizeIngredientKey(requiredKey);

  if (available == required) return true;
  if (isGenericFishIngredient(availableKey) && isFishIngredient(requiredKey)) {
    return true;
  }
  if (isFishIngredient(availableKey) && isGenericFishIngredient(requiredKey)) {
    return true;
  }
  if (isChiliIngredient(availableKey) && isChiliIngredient(requiredKey)) {
    return true;
  }
  if (isRiceIngredient(availableKey) && isRiceIngredient(requiredKey)) {
    return true;
  }
  return false;
}
