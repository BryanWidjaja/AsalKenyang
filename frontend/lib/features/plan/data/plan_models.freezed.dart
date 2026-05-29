// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlannedMeal {

 String get id; DateTime get date; String get recipeId; String get mealSlot;
/// Create a copy of PlannedMeal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedMealCopyWith<PlannedMeal> get copyWith => _$PlannedMealCopyWithImpl<PlannedMeal>(this as PlannedMeal, _$identity);

  /// Serializes this PlannedMeal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedMeal&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.mealSlot, mealSlot) || other.mealSlot == mealSlot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,recipeId,mealSlot);

@override
String toString() {
  return 'PlannedMeal(id: $id, date: $date, recipeId: $recipeId, mealSlot: $mealSlot)';
}


}

/// @nodoc
abstract mixin class $PlannedMealCopyWith<$Res>  {
  factory $PlannedMealCopyWith(PlannedMeal value, $Res Function(PlannedMeal) _then) = _$PlannedMealCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String recipeId, String mealSlot
});




}
/// @nodoc
class _$PlannedMealCopyWithImpl<$Res>
    implements $PlannedMealCopyWith<$Res> {
  _$PlannedMealCopyWithImpl(this._self, this._then);

  final PlannedMeal _self;
  final $Res Function(PlannedMeal) _then;

/// Create a copy of PlannedMeal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? recipeId = null,Object? mealSlot = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,mealSlot: null == mealSlot ? _self.mealSlot : mealSlot // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedMeal].
extension PlannedMealPatterns on PlannedMeal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedMeal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedMeal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedMeal value)  $default,){
final _that = this;
switch (_that) {
case _PlannedMeal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedMeal value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedMeal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String recipeId,  String mealSlot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedMeal() when $default != null:
return $default(_that.id,_that.date,_that.recipeId,_that.mealSlot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String recipeId,  String mealSlot)  $default,) {final _that = this;
switch (_that) {
case _PlannedMeal():
return $default(_that.id,_that.date,_that.recipeId,_that.mealSlot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String recipeId,  String mealSlot)?  $default,) {final _that = this;
switch (_that) {
case _PlannedMeal() when $default != null:
return $default(_that.id,_that.date,_that.recipeId,_that.mealSlot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlannedMeal implements PlannedMeal {
  const _PlannedMeal({required this.id, required this.date, required this.recipeId, required this.mealSlot});
  factory _PlannedMeal.fromJson(Map<String, dynamic> json) => _$PlannedMealFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  String recipeId;
@override final  String mealSlot;

/// Create a copy of PlannedMeal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedMealCopyWith<_PlannedMeal> get copyWith => __$PlannedMealCopyWithImpl<_PlannedMeal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannedMealToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedMeal&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.mealSlot, mealSlot) || other.mealSlot == mealSlot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,recipeId,mealSlot);

@override
String toString() {
  return 'PlannedMeal(id: $id, date: $date, recipeId: $recipeId, mealSlot: $mealSlot)';
}


}

/// @nodoc
abstract mixin class _$PlannedMealCopyWith<$Res> implements $PlannedMealCopyWith<$Res> {
  factory _$PlannedMealCopyWith(_PlannedMeal value, $Res Function(_PlannedMeal) _then) = __$PlannedMealCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String recipeId, String mealSlot
});




}
/// @nodoc
class __$PlannedMealCopyWithImpl<$Res>
    implements _$PlannedMealCopyWith<$Res> {
  __$PlannedMealCopyWithImpl(this._self, this._then);

  final _PlannedMeal _self;
  final $Res Function(_PlannedMeal) _then;

/// Create a copy of PlannedMeal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? recipeId = null,Object? mealSlot = null,}) {
  return _then(_PlannedMeal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,mealSlot: null == mealSlot ? _self.mealSlot : mealSlot // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
