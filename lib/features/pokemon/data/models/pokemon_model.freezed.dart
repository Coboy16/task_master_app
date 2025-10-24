// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonModel {

 int get id; String get name; String? get imageUrl; List<String> get types; int? get height; int? get weight; List<PokemonAbilityModel> get abilities; List<PokemonStatModel> get stats; bool get isFavorite;
/// Create a copy of PokemonModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonModelCopyWith<PokemonModel> get copyWith => _$PokemonModelCopyWithImpl<PokemonModel>(this as PokemonModel, _$identity);

  /// Serializes this PokemonModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other.abilities, abilities)&&const DeepCollectionEquality().equals(other.stats, stats)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,const DeepCollectionEquality().hash(types),height,weight,const DeepCollectionEquality().hash(abilities),const DeepCollectionEquality().hash(stats),isFavorite);

@override
String toString() {
  return 'PokemonModel(id: $id, name: $name, imageUrl: $imageUrl, types: $types, height: $height, weight: $weight, abilities: $abilities, stats: $stats, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $PokemonModelCopyWith<$Res>  {
  factory $PokemonModelCopyWith(PokemonModel value, $Res Function(PokemonModel) _then) = _$PokemonModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? imageUrl, List<String> types, int? height, int? weight, List<PokemonAbilityModel> abilities, List<PokemonStatModel> stats, bool isFavorite
});




}
/// @nodoc
class _$PokemonModelCopyWithImpl<$Res>
    implements $PokemonModelCopyWith<$Res> {
  _$PokemonModelCopyWithImpl(this._self, this._then);

  final PokemonModel _self;
  final $Res Function(PokemonModel) _then;

/// Create a copy of PokemonModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,Object? types = null,Object? height = freezed,Object? weight = freezed,Object? abilities = null,Object? stats = null,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,abilities: null == abilities ? _self.abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<PokemonAbilityModel>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<PokemonStatModel>,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonModel].
extension PokemonModelPatterns on PokemonModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonModel value)  $default,){
final _that = this;
switch (_that) {
case _PokemonModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonModel value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? imageUrl,  List<String> types,  int? height,  int? weight,  List<PokemonAbilityModel> abilities,  List<PokemonStatModel> stats,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonModel() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.types,_that.height,_that.weight,_that.abilities,_that.stats,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? imageUrl,  List<String> types,  int? height,  int? weight,  List<PokemonAbilityModel> abilities,  List<PokemonStatModel> stats,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _PokemonModel():
return $default(_that.id,_that.name,_that.imageUrl,_that.types,_that.height,_that.weight,_that.abilities,_that.stats,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? imageUrl,  List<String> types,  int? height,  int? weight,  List<PokemonAbilityModel> abilities,  List<PokemonStatModel> stats,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _PokemonModel() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.types,_that.height,_that.weight,_that.abilities,_that.stats,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokemonModel implements PokemonModel {
  const _PokemonModel({required this.id, required this.name, this.imageUrl, required final  List<String> types, this.height, this.weight, final  List<PokemonAbilityModel> abilities = const [], final  List<PokemonStatModel> stats = const [], this.isFavorite = false}): _types = types,_abilities = abilities,_stats = stats;
  factory _PokemonModel.fromJson(Map<String, dynamic> json) => _$PokemonModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? imageUrl;
 final  List<String> _types;
@override List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  int? height;
@override final  int? weight;
 final  List<PokemonAbilityModel> _abilities;
@override@JsonKey() List<PokemonAbilityModel> get abilities {
  if (_abilities is EqualUnmodifiableListView) return _abilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abilities);
}

 final  List<PokemonStatModel> _stats;
@override@JsonKey() List<PokemonStatModel> get stats {
  if (_stats is EqualUnmodifiableListView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stats);
}

@override@JsonKey() final  bool isFavorite;

/// Create a copy of PokemonModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonModelCopyWith<_PokemonModel> get copyWith => __$PokemonModelCopyWithImpl<_PokemonModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokemonModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other._abilities, _abilities)&&const DeepCollectionEquality().equals(other._stats, _stats)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,const DeepCollectionEquality().hash(_types),height,weight,const DeepCollectionEquality().hash(_abilities),const DeepCollectionEquality().hash(_stats),isFavorite);

@override
String toString() {
  return 'PokemonModel(id: $id, name: $name, imageUrl: $imageUrl, types: $types, height: $height, weight: $weight, abilities: $abilities, stats: $stats, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$PokemonModelCopyWith<$Res> implements $PokemonModelCopyWith<$Res> {
  factory _$PokemonModelCopyWith(_PokemonModel value, $Res Function(_PokemonModel) _then) = __$PokemonModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? imageUrl, List<String> types, int? height, int? weight, List<PokemonAbilityModel> abilities, List<PokemonStatModel> stats, bool isFavorite
});




}
/// @nodoc
class __$PokemonModelCopyWithImpl<$Res>
    implements _$PokemonModelCopyWith<$Res> {
  __$PokemonModelCopyWithImpl(this._self, this._then);

  final _PokemonModel _self;
  final $Res Function(_PokemonModel) _then;

/// Create a copy of PokemonModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,Object? types = null,Object? height = freezed,Object? weight = freezed,Object? abilities = null,Object? stats = null,Object? isFavorite = null,}) {
  return _then(_PokemonModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,abilities: null == abilities ? _self._abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<PokemonAbilityModel>,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as List<PokemonStatModel>,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
