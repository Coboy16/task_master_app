// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PokemonDetailState {

 Pokemon? get pokemon; bool get isLoading; String? get errorMessage;
/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonDetailStateCopyWith<PokemonDetailState> get copyWith => _$PokemonDetailStateCopyWithImpl<PokemonDetailState>(this as PokemonDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonDetailState&&(identical(other.pokemon, pokemon) || other.pokemon == pokemon)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pokemon,isLoading,errorMessage);

@override
String toString() {
  return 'PokemonDetailState(pokemon: $pokemon, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PokemonDetailStateCopyWith<$Res>  {
  factory $PokemonDetailStateCopyWith(PokemonDetailState value, $Res Function(PokemonDetailState) _then) = _$PokemonDetailStateCopyWithImpl;
@useResult
$Res call({
 Pokemon? pokemon, bool isLoading, String? errorMessage
});


$PokemonCopyWith<$Res>? get pokemon;

}
/// @nodoc
class _$PokemonDetailStateCopyWithImpl<$Res>
    implements $PokemonDetailStateCopyWith<$Res> {
  _$PokemonDetailStateCopyWithImpl(this._self, this._then);

  final PokemonDetailState _self;
  final $Res Function(PokemonDetailState) _then;

/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pokemon = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
pokemon: freezed == pokemon ? _self.pokemon : pokemon // ignore: cast_nullable_to_non_nullable
as Pokemon?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokemonCopyWith<$Res>? get pokemon {
    if (_self.pokemon == null) {
    return null;
  }

  return $PokemonCopyWith<$Res>(_self.pokemon!, (value) {
    return _then(_self.copyWith(pokemon: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokemonDetailState].
extension PokemonDetailStatePatterns on PokemonDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonDetailState value)  $default,){
final _that = this;
switch (_that) {
case _PokemonDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Pokemon? pokemon,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonDetailState() when $default != null:
return $default(_that.pokemon,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Pokemon? pokemon,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PokemonDetailState():
return $default(_that.pokemon,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Pokemon? pokemon,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PokemonDetailState() when $default != null:
return $default(_that.pokemon,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PokemonDetailState implements PokemonDetailState {
  const _PokemonDetailState({this.pokemon, this.isLoading = false, this.errorMessage});
  

@override final  Pokemon? pokemon;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonDetailStateCopyWith<_PokemonDetailState> get copyWith => __$PokemonDetailStateCopyWithImpl<_PokemonDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonDetailState&&(identical(other.pokemon, pokemon) || other.pokemon == pokemon)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pokemon,isLoading,errorMessage);

@override
String toString() {
  return 'PokemonDetailState(pokemon: $pokemon, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PokemonDetailStateCopyWith<$Res> implements $PokemonDetailStateCopyWith<$Res> {
  factory _$PokemonDetailStateCopyWith(_PokemonDetailState value, $Res Function(_PokemonDetailState) _then) = __$PokemonDetailStateCopyWithImpl;
@override @useResult
$Res call({
 Pokemon? pokemon, bool isLoading, String? errorMessage
});


@override $PokemonCopyWith<$Res>? get pokemon;

}
/// @nodoc
class __$PokemonDetailStateCopyWithImpl<$Res>
    implements _$PokemonDetailStateCopyWith<$Res> {
  __$PokemonDetailStateCopyWithImpl(this._self, this._then);

  final _PokemonDetailState _self;
  final $Res Function(_PokemonDetailState) _then;

/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pokemon = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_PokemonDetailState(
pokemon: freezed == pokemon ? _self.pokemon : pokemon // ignore: cast_nullable_to_non_nullable
as Pokemon?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PokemonDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokemonCopyWith<$Res>? get pokemon {
    if (_self.pokemon == null) {
    return null;
  }

  return $PokemonCopyWith<$Res>(_self.pokemon!, (value) {
    return _then(_self.copyWith(pokemon: value));
  });
}
}

// dart format on
