// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_ability_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonAbilityModel {

 String get name; bool get isHidden;
/// Create a copy of PokemonAbilityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonAbilityModelCopyWith<PokemonAbilityModel> get copyWith => _$PokemonAbilityModelCopyWithImpl<PokemonAbilityModel>(this as PokemonAbilityModel, _$identity);

  /// Serializes this PokemonAbilityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonAbilityModel&&(identical(other.name, name) || other.name == name)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,isHidden);

@override
String toString() {
  return 'PokemonAbilityModel(name: $name, isHidden: $isHidden)';
}


}

/// @nodoc
abstract mixin class $PokemonAbilityModelCopyWith<$Res>  {
  factory $PokemonAbilityModelCopyWith(PokemonAbilityModel value, $Res Function(PokemonAbilityModel) _then) = _$PokemonAbilityModelCopyWithImpl;
@useResult
$Res call({
 String name, bool isHidden
});




}
/// @nodoc
class _$PokemonAbilityModelCopyWithImpl<$Res>
    implements $PokemonAbilityModelCopyWith<$Res> {
  _$PokemonAbilityModelCopyWithImpl(this._self, this._then);

  final PokemonAbilityModel _self;
  final $Res Function(PokemonAbilityModel) _then;

/// Create a copy of PokemonAbilityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? isHidden = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonAbilityModel].
extension PokemonAbilityModelPatterns on PokemonAbilityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonAbilityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonAbilityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonAbilityModel value)  $default,){
final _that = this;
switch (_that) {
case _PokemonAbilityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonAbilityModel value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonAbilityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool isHidden)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonAbilityModel() when $default != null:
return $default(_that.name,_that.isHidden);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool isHidden)  $default,) {final _that = this;
switch (_that) {
case _PokemonAbilityModel():
return $default(_that.name,_that.isHidden);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool isHidden)?  $default,) {final _that = this;
switch (_that) {
case _PokemonAbilityModel() when $default != null:
return $default(_that.name,_that.isHidden);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokemonAbilityModel implements PokemonAbilityModel {
  const _PokemonAbilityModel({required this.name, this.isHidden = false});
  factory _PokemonAbilityModel.fromJson(Map<String, dynamic> json) => _$PokemonAbilityModelFromJson(json);

@override final  String name;
@override@JsonKey() final  bool isHidden;

/// Create a copy of PokemonAbilityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonAbilityModelCopyWith<_PokemonAbilityModel> get copyWith => __$PokemonAbilityModelCopyWithImpl<_PokemonAbilityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokemonAbilityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonAbilityModel&&(identical(other.name, name) || other.name == name)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,isHidden);

@override
String toString() {
  return 'PokemonAbilityModel(name: $name, isHidden: $isHidden)';
}


}

/// @nodoc
abstract mixin class _$PokemonAbilityModelCopyWith<$Res> implements $PokemonAbilityModelCopyWith<$Res> {
  factory _$PokemonAbilityModelCopyWith(_PokemonAbilityModel value, $Res Function(_PokemonAbilityModel) _then) = __$PokemonAbilityModelCopyWithImpl;
@override @useResult
$Res call({
 String name, bool isHidden
});




}
/// @nodoc
class __$PokemonAbilityModelCopyWithImpl<$Res>
    implements _$PokemonAbilityModelCopyWith<$Res> {
  __$PokemonAbilityModelCopyWithImpl(this._self, this._then);

  final _PokemonAbilityModel _self;
  final $Res Function(_PokemonAbilityModel) _then;

/// Create a copy of PokemonAbilityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? isHidden = null,}) {
  return _then(_PokemonAbilityModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
