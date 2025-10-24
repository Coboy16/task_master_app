// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_stat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonStatModel {

 String get name; int get baseStat;
/// Create a copy of PokemonStatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonStatModelCopyWith<PokemonStatModel> get copyWith => _$PokemonStatModelCopyWithImpl<PokemonStatModel>(this as PokemonStatModel, _$identity);

  /// Serializes this PokemonStatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonStatModel&&(identical(other.name, name) || other.name == name)&&(identical(other.baseStat, baseStat) || other.baseStat == baseStat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,baseStat);

@override
String toString() {
  return 'PokemonStatModel(name: $name, baseStat: $baseStat)';
}


}

/// @nodoc
abstract mixin class $PokemonStatModelCopyWith<$Res>  {
  factory $PokemonStatModelCopyWith(PokemonStatModel value, $Res Function(PokemonStatModel) _then) = _$PokemonStatModelCopyWithImpl;
@useResult
$Res call({
 String name, int baseStat
});




}
/// @nodoc
class _$PokemonStatModelCopyWithImpl<$Res>
    implements $PokemonStatModelCopyWith<$Res> {
  _$PokemonStatModelCopyWithImpl(this._self, this._then);

  final PokemonStatModel _self;
  final $Res Function(PokemonStatModel) _then;

/// Create a copy of PokemonStatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? baseStat = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseStat: null == baseStat ? _self.baseStat : baseStat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonStatModel].
extension PokemonStatModelPatterns on PokemonStatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonStatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonStatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonStatModel value)  $default,){
final _that = this;
switch (_that) {
case _PokemonStatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonStatModel value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonStatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int baseStat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonStatModel() when $default != null:
return $default(_that.name,_that.baseStat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int baseStat)  $default,) {final _that = this;
switch (_that) {
case _PokemonStatModel():
return $default(_that.name,_that.baseStat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int baseStat)?  $default,) {final _that = this;
switch (_that) {
case _PokemonStatModel() when $default != null:
return $default(_that.name,_that.baseStat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokemonStatModel implements PokemonStatModel {
  const _PokemonStatModel({required this.name, required this.baseStat});
  factory _PokemonStatModel.fromJson(Map<String, dynamic> json) => _$PokemonStatModelFromJson(json);

@override final  String name;
@override final  int baseStat;

/// Create a copy of PokemonStatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonStatModelCopyWith<_PokemonStatModel> get copyWith => __$PokemonStatModelCopyWithImpl<_PokemonStatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokemonStatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonStatModel&&(identical(other.name, name) || other.name == name)&&(identical(other.baseStat, baseStat) || other.baseStat == baseStat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,baseStat);

@override
String toString() {
  return 'PokemonStatModel(name: $name, baseStat: $baseStat)';
}


}

/// @nodoc
abstract mixin class _$PokemonStatModelCopyWith<$Res> implements $PokemonStatModelCopyWith<$Res> {
  factory _$PokemonStatModelCopyWith(_PokemonStatModel value, $Res Function(_PokemonStatModel) _then) = __$PokemonStatModelCopyWithImpl;
@override @useResult
$Res call({
 String name, int baseStat
});




}
/// @nodoc
class __$PokemonStatModelCopyWithImpl<$Res>
    implements _$PokemonStatModelCopyWith<$Res> {
  __$PokemonStatModelCopyWithImpl(this._self, this._then);

  final _PokemonStatModel _self;
  final $Res Function(_PokemonStatModel) _then;

/// Create a copy of PokemonStatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? baseStat = null,}) {
  return _then(_PokemonStatModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseStat: null == baseStat ? _self.baseStat : baseStat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
