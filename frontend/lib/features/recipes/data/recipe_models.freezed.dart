// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bahan {

 String get nama; String get jumlah; int get harga; String get key; double? get gram;
/// Create a copy of Bahan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BahanCopyWith<Bahan> get copyWith => _$BahanCopyWithImpl<Bahan>(this as Bahan, _$identity);

  /// Serializes this Bahan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bahan&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.jumlah, jumlah) || other.jumlah == jumlah)&&(identical(other.harga, harga) || other.harga == harga)&&(identical(other.key, key) || other.key == key)&&(identical(other.gram, gram) || other.gram == gram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nama,jumlah,harga,key,gram);

@override
String toString() {
  return 'Bahan(nama: $nama, jumlah: $jumlah, harga: $harga, key: $key, gram: $gram)';
}


}

/// @nodoc
abstract mixin class $BahanCopyWith<$Res>  {
  factory $BahanCopyWith(Bahan value, $Res Function(Bahan) _then) = _$BahanCopyWithImpl;
@useResult
$Res call({
 String nama, String jumlah, int harga, String key, double? gram
});




}
/// @nodoc
class _$BahanCopyWithImpl<$Res>
    implements $BahanCopyWith<$Res> {
  _$BahanCopyWithImpl(this._self, this._then);

  final Bahan _self;
  final $Res Function(Bahan) _then;

/// Create a copy of Bahan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nama = null,Object? jumlah = null,Object? harga = null,Object? key = null,Object? gram = freezed,}) {
  return _then(_self.copyWith(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as String,harga: null == harga ? _self.harga : harga // ignore: cast_nullable_to_non_nullable
as int,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,gram: freezed == gram ? _self.gram : gram // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bahan].
extension BahanPatterns on Bahan {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bahan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bahan() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bahan value)  $default,){
final _that = this;
switch (_that) {
case _Bahan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bahan value)?  $default,){
final _that = this;
switch (_that) {
case _Bahan() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nama,  String jumlah,  int harga,  String key,  double? gram)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bahan() when $default != null:
return $default(_that.nama,_that.jumlah,_that.harga,_that.key,_that.gram);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nama,  String jumlah,  int harga,  String key,  double? gram)  $default,) {final _that = this;
switch (_that) {
case _Bahan():
return $default(_that.nama,_that.jumlah,_that.harga,_that.key,_that.gram);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nama,  String jumlah,  int harga,  String key,  double? gram)?  $default,) {final _that = this;
switch (_that) {
case _Bahan() when $default != null:
return $default(_that.nama,_that.jumlah,_that.harga,_that.key,_that.gram);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bahan implements Bahan {
  const _Bahan({required this.nama, required this.jumlah, required this.harga, required this.key, this.gram});
  factory _Bahan.fromJson(Map<String, dynamic> json) => _$BahanFromJson(json);

@override final  String nama;
@override final  String jumlah;
@override final  int harga;
@override final  String key;
@override final  double? gram;

/// Create a copy of Bahan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BahanCopyWith<_Bahan> get copyWith => __$BahanCopyWithImpl<_Bahan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BahanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bahan&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.jumlah, jumlah) || other.jumlah == jumlah)&&(identical(other.harga, harga) || other.harga == harga)&&(identical(other.key, key) || other.key == key)&&(identical(other.gram, gram) || other.gram == gram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nama,jumlah,harga,key,gram);

@override
String toString() {
  return 'Bahan(nama: $nama, jumlah: $jumlah, harga: $harga, key: $key, gram: $gram)';
}


}

/// @nodoc
abstract mixin class _$BahanCopyWith<$Res> implements $BahanCopyWith<$Res> {
  factory _$BahanCopyWith(_Bahan value, $Res Function(_Bahan) _then) = __$BahanCopyWithImpl;
@override @useResult
$Res call({
 String nama, String jumlah, int harga, String key, double? gram
});




}
/// @nodoc
class __$BahanCopyWithImpl<$Res>
    implements _$BahanCopyWith<$Res> {
  __$BahanCopyWithImpl(this._self, this._then);

  final _Bahan _self;
  final $Res Function(_Bahan) _then;

/// Create a copy of Bahan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nama = null,Object? jumlah = null,Object? harga = null,Object? key = null,Object? gram = freezed,}) {
  return _then(_Bahan(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as String,harga: null == harga ? _self.harga : harga // ignore: cast_nullable_to_non_nullable
as int,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,gram: freezed == gram ? _self.gram : gram // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$Recipe {

 String get id; String get name; String get kategori; int get porsi; int get estPrice; int get estCalories; int get cookTime; String get imageUrl; List<String> get alat; List<Bahan> get bahan; List<String> get bahanKey; List<String> get langkah; List<String> get tags; bool get halal;
/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeCopyWith<Recipe> get copyWith => _$RecipeCopyWithImpl<Recipe>(this as Recipe, _$identity);

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recipe&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kategori, kategori) || other.kategori == kategori)&&(identical(other.porsi, porsi) || other.porsi == porsi)&&(identical(other.estPrice, estPrice) || other.estPrice == estPrice)&&(identical(other.estCalories, estCalories) || other.estCalories == estCalories)&&(identical(other.cookTime, cookTime) || other.cookTime == cookTime)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.alat, alat)&&const DeepCollectionEquality().equals(other.bahan, bahan)&&const DeepCollectionEquality().equals(other.bahanKey, bahanKey)&&const DeepCollectionEquality().equals(other.langkah, langkah)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.halal, halal) || other.halal == halal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kategori,porsi,estPrice,estCalories,cookTime,imageUrl,const DeepCollectionEquality().hash(alat),const DeepCollectionEquality().hash(bahan),const DeepCollectionEquality().hash(bahanKey),const DeepCollectionEquality().hash(langkah),const DeepCollectionEquality().hash(tags),halal);

@override
String toString() {
  return 'Recipe(id: $id, name: $name, kategori: $kategori, porsi: $porsi, estPrice: $estPrice, estCalories: $estCalories, cookTime: $cookTime, imageUrl: $imageUrl, alat: $alat, bahan: $bahan, bahanKey: $bahanKey, langkah: $langkah, tags: $tags, halal: $halal)';
}


}

/// @nodoc
abstract mixin class $RecipeCopyWith<$Res>  {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) _then) = _$RecipeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kategori, int porsi, int estPrice, int estCalories, int cookTime, String imageUrl, List<String> alat, List<Bahan> bahan, List<String> bahanKey, List<String> langkah, List<String> tags, bool halal
});




}
/// @nodoc
class _$RecipeCopyWithImpl<$Res>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._self, this._then);

  final Recipe _self;
  final $Res Function(Recipe) _then;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kategori = null,Object? porsi = null,Object? estPrice = null,Object? estCalories = null,Object? cookTime = null,Object? imageUrl = null,Object? alat = null,Object? bahan = null,Object? bahanKey = null,Object? langkah = null,Object? tags = null,Object? halal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kategori: null == kategori ? _self.kategori : kategori // ignore: cast_nullable_to_non_nullable
as String,porsi: null == porsi ? _self.porsi : porsi // ignore: cast_nullable_to_non_nullable
as int,estPrice: null == estPrice ? _self.estPrice : estPrice // ignore: cast_nullable_to_non_nullable
as int,estCalories: null == estCalories ? _self.estCalories : estCalories // ignore: cast_nullable_to_non_nullable
as int,cookTime: null == cookTime ? _self.cookTime : cookTime // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,alat: null == alat ? _self.alat : alat // ignore: cast_nullable_to_non_nullable
as List<String>,bahan: null == bahan ? _self.bahan : bahan // ignore: cast_nullable_to_non_nullable
as List<Bahan>,bahanKey: null == bahanKey ? _self.bahanKey : bahanKey // ignore: cast_nullable_to_non_nullable
as List<String>,langkah: null == langkah ? _self.langkah : langkah // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,halal: null == halal ? _self.halal : halal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Recipe].
extension RecipePatterns on Recipe {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recipe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recipe value)  $default,){
final _that = this;
switch (_that) {
case _Recipe():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recipe value)?  $default,){
final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kategori,  int porsi,  int estPrice,  int estCalories,  int cookTime,  String imageUrl,  List<String> alat,  List<Bahan> bahan,  List<String> bahanKey,  List<String> langkah,  List<String> tags,  bool halal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that.id,_that.name,_that.kategori,_that.porsi,_that.estPrice,_that.estCalories,_that.cookTime,_that.imageUrl,_that.alat,_that.bahan,_that.bahanKey,_that.langkah,_that.tags,_that.halal);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kategori,  int porsi,  int estPrice,  int estCalories,  int cookTime,  String imageUrl,  List<String> alat,  List<Bahan> bahan,  List<String> bahanKey,  List<String> langkah,  List<String> tags,  bool halal)  $default,) {final _that = this;
switch (_that) {
case _Recipe():
return $default(_that.id,_that.name,_that.kategori,_that.porsi,_that.estPrice,_that.estCalories,_that.cookTime,_that.imageUrl,_that.alat,_that.bahan,_that.bahanKey,_that.langkah,_that.tags,_that.halal);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kategori,  int porsi,  int estPrice,  int estCalories,  int cookTime,  String imageUrl,  List<String> alat,  List<Bahan> bahan,  List<String> bahanKey,  List<String> langkah,  List<String> tags,  bool halal)?  $default,) {final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that.id,_that.name,_that.kategori,_that.porsi,_that.estPrice,_that.estCalories,_that.cookTime,_that.imageUrl,_that.alat,_that.bahan,_that.bahanKey,_that.langkah,_that.tags,_that.halal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Recipe implements Recipe {
  const _Recipe({required this.id, required this.name, required this.kategori, required this.porsi, required this.estPrice, required this.estCalories, required this.cookTime, required this.imageUrl, required final  List<String> alat, required final  List<Bahan> bahan, required final  List<String> bahanKey, required final  List<String> langkah, required final  List<String> tags, required this.halal}): _alat = alat,_bahan = bahan,_bahanKey = bahanKey,_langkah = langkah,_tags = tags;
  factory _Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String kategori;
@override final  int porsi;
@override final  int estPrice;
@override final  int estCalories;
@override final  int cookTime;
@override final  String imageUrl;
 final  List<String> _alat;
@override List<String> get alat {
  if (_alat is EqualUnmodifiableListView) return _alat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alat);
}

 final  List<Bahan> _bahan;
@override List<Bahan> get bahan {
  if (_bahan is EqualUnmodifiableListView) return _bahan;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bahan);
}

 final  List<String> _bahanKey;
@override List<String> get bahanKey {
  if (_bahanKey is EqualUnmodifiableListView) return _bahanKey;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bahanKey);
}

 final  List<String> _langkah;
@override List<String> get langkah {
  if (_langkah is EqualUnmodifiableListView) return _langkah;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_langkah);
}

 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  bool halal;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeCopyWith<_Recipe> get copyWith => __$RecipeCopyWithImpl<_Recipe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recipe&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kategori, kategori) || other.kategori == kategori)&&(identical(other.porsi, porsi) || other.porsi == porsi)&&(identical(other.estPrice, estPrice) || other.estPrice == estPrice)&&(identical(other.estCalories, estCalories) || other.estCalories == estCalories)&&(identical(other.cookTime, cookTime) || other.cookTime == cookTime)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._alat, _alat)&&const DeepCollectionEquality().equals(other._bahan, _bahan)&&const DeepCollectionEquality().equals(other._bahanKey, _bahanKey)&&const DeepCollectionEquality().equals(other._langkah, _langkah)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.halal, halal) || other.halal == halal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kategori,porsi,estPrice,estCalories,cookTime,imageUrl,const DeepCollectionEquality().hash(_alat),const DeepCollectionEquality().hash(_bahan),const DeepCollectionEquality().hash(_bahanKey),const DeepCollectionEquality().hash(_langkah),const DeepCollectionEquality().hash(_tags),halal);

@override
String toString() {
  return 'Recipe(id: $id, name: $name, kategori: $kategori, porsi: $porsi, estPrice: $estPrice, estCalories: $estCalories, cookTime: $cookTime, imageUrl: $imageUrl, alat: $alat, bahan: $bahan, bahanKey: $bahanKey, langkah: $langkah, tags: $tags, halal: $halal)';
}


}

/// @nodoc
abstract mixin class _$RecipeCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$RecipeCopyWith(_Recipe value, $Res Function(_Recipe) _then) = __$RecipeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kategori, int porsi, int estPrice, int estCalories, int cookTime, String imageUrl, List<String> alat, List<Bahan> bahan, List<String> bahanKey, List<String> langkah, List<String> tags, bool halal
});




}
/// @nodoc
class __$RecipeCopyWithImpl<$Res>
    implements _$RecipeCopyWith<$Res> {
  __$RecipeCopyWithImpl(this._self, this._then);

  final _Recipe _self;
  final $Res Function(_Recipe) _then;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kategori = null,Object? porsi = null,Object? estPrice = null,Object? estCalories = null,Object? cookTime = null,Object? imageUrl = null,Object? alat = null,Object? bahan = null,Object? bahanKey = null,Object? langkah = null,Object? tags = null,Object? halal = null,}) {
  return _then(_Recipe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kategori: null == kategori ? _self.kategori : kategori // ignore: cast_nullable_to_non_nullable
as String,porsi: null == porsi ? _self.porsi : porsi // ignore: cast_nullable_to_non_nullable
as int,estPrice: null == estPrice ? _self.estPrice : estPrice // ignore: cast_nullable_to_non_nullable
as int,estCalories: null == estCalories ? _self.estCalories : estCalories // ignore: cast_nullable_to_non_nullable
as int,cookTime: null == cookTime ? _self.cookTime : cookTime // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,alat: null == alat ? _self._alat : alat // ignore: cast_nullable_to_non_nullable
as List<String>,bahan: null == bahan ? _self._bahan : bahan // ignore: cast_nullable_to_non_nullable
as List<Bahan>,bahanKey: null == bahanKey ? _self._bahanKey : bahanKey // ignore: cast_nullable_to_non_nullable
as List<String>,langkah: null == langkah ? _self._langkah : langkah // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,halal: null == halal ? _self.halal : halal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
