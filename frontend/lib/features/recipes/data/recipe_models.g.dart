// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bahan _$BahanFromJson(Map<String, dynamic> json) => _Bahan(
  nama: json['nama'] as String,
  jumlah: json['jumlah'] as String,
  harga: (json['harga'] as num?)?.toInt() ?? 0,
  key: json['key'] as String,
);

Map<String, dynamic> _$BahanToJson(_Bahan instance) => <String, dynamic>{
  'nama': instance.nama,
  'jumlah': instance.jumlah,
  'harga': instance.harga,
  'key': instance.key,
};

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
  id: json['id'] as String,
  name: json['name'] as String,
  kategori: json['kategori'] as String,
  porsi: (json['porsi'] as num).toInt(),
  estPrice: (json['estPrice'] as num).toInt(),
  estCalories: (json['estCalories'] as num).toInt(),
  cookTime: (json['cookTime'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  alat: (json['alat'] as List<dynamic>).map((e) => e as String).toList(),
  bahan: (json['bahan'] as List<dynamic>)
      .map((e) => Bahan.fromJson(e as Map<String, dynamic>))
      .toList(),
  bahanKey: (json['bahanKey'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  langkah: (json['langkah'] as List<dynamic>).map((e) => e as String).toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  halal: json['halal'] as bool,
);

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'kategori': instance.kategori,
  'porsi': instance.porsi,
  'estPrice': instance.estPrice,
  'estCalories': instance.estCalories,
  'cookTime': instance.cookTime,
  'imageUrl': instance.imageUrl,
  'alat': instance.alat,
  'bahan': instance.bahan,
  'bahanKey': instance.bahanKey,
  'langkah': instance.langkah,
  'tags': instance.tags,
  'halal': instance.halal,
};
