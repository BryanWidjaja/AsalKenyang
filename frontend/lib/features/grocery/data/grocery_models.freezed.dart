// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroceryItemState {

 String get bahanKey; bool get isChecked;
/// Create a copy of GroceryItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroceryItemStateCopyWith<GroceryItemState> get copyWith => _$GroceryItemStateCopyWithImpl<GroceryItemState>(this as GroceryItemState, _$identity);

  /// Serializes this GroceryItemState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroceryItemState&&(identical(other.bahanKey, bahanKey) || other.bahanKey == bahanKey)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bahanKey,isChecked);

@override
String toString() {
  return 'GroceryItemState(bahanKey: $bahanKey, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class $GroceryItemStateCopyWith<$Res>  {
  factory $GroceryItemStateCopyWith(GroceryItemState value, $Res Function(GroceryItemState) _then) = _$GroceryItemStateCopyWithImpl;
@useResult
$Res call({
 String bahanKey, bool isChecked
});




}
/// @nodoc
class _$GroceryItemStateCopyWithImpl<$Res>
    implements $GroceryItemStateCopyWith<$Res> {
  _$GroceryItemStateCopyWithImpl(this._self, this._then);

  final GroceryItemState _self;
  final $Res Function(GroceryItemState) _then;

/// Create a copy of GroceryItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bahanKey = null,Object? isChecked = null,}) {
  return _then(_self.copyWith(
bahanKey: null == bahanKey ? _self.bahanKey : bahanKey // ignore: cast_nullable_to_non_nullable
as String,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GroceryItemState].
extension GroceryItemStatePatterns on GroceryItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroceryItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroceryItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroceryItemState value)  $default,){
final _that = this;
switch (_that) {
case _GroceryItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroceryItemState value)?  $default,){
final _that = this;
switch (_that) {
case _GroceryItemState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bahanKey,  bool isChecked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroceryItemState() when $default != null:
return $default(_that.bahanKey,_that.isChecked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bahanKey,  bool isChecked)  $default,) {final _that = this;
switch (_that) {
case _GroceryItemState():
return $default(_that.bahanKey,_that.isChecked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bahanKey,  bool isChecked)?  $default,) {final _that = this;
switch (_that) {
case _GroceryItemState() when $default != null:
return $default(_that.bahanKey,_that.isChecked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroceryItemState implements GroceryItemState {
  const _GroceryItemState({required this.bahanKey, required this.isChecked});
  factory _GroceryItemState.fromJson(Map<String, dynamic> json) => _$GroceryItemStateFromJson(json);

@override final  String bahanKey;
@override final  bool isChecked;

/// Create a copy of GroceryItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroceryItemStateCopyWith<_GroceryItemState> get copyWith => __$GroceryItemStateCopyWithImpl<_GroceryItemState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroceryItemStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroceryItemState&&(identical(other.bahanKey, bahanKey) || other.bahanKey == bahanKey)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bahanKey,isChecked);

@override
String toString() {
  return 'GroceryItemState(bahanKey: $bahanKey, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class _$GroceryItemStateCopyWith<$Res> implements $GroceryItemStateCopyWith<$Res> {
  factory _$GroceryItemStateCopyWith(_GroceryItemState value, $Res Function(_GroceryItemState) _then) = __$GroceryItemStateCopyWithImpl;
@override @useResult
$Res call({
 String bahanKey, bool isChecked
});




}
/// @nodoc
class __$GroceryItemStateCopyWithImpl<$Res>
    implements _$GroceryItemStateCopyWith<$Res> {
  __$GroceryItemStateCopyWithImpl(this._self, this._then);

  final _GroceryItemState _self;
  final $Res Function(_GroceryItemState) _then;

/// Create a copy of GroceryItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bahanKey = null,Object? isChecked = null,}) {
  return _then(_GroceryItemState(
bahanKey: null == bahanKey ? _self.bahanKey : bahanKey // ignore: cast_nullable_to_non_nullable
as String,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
