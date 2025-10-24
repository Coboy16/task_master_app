// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PokemonListState {

 List<Pokemon> get pokemonList; bool get isLoading; bool get isLoadingMore; bool get hasMore; int get currentOffset; String? get errorMessage;
/// Create a copy of PokemonListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonListStateCopyWith<PokemonListState> get copyWith => _$PokemonListStateCopyWithImpl<PokemonListState>(this as PokemonListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonListState&&const DeepCollectionEquality().equals(other.pokemonList, pokemonList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentOffset, currentOffset) || other.currentOffset == currentOffset)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pokemonList),isLoading,isLoadingMore,hasMore,currentOffset,errorMessage);

@override
String toString() {
  return 'PokemonListState(pokemonList: $pokemonList, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentOffset: $currentOffset, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PokemonListStateCopyWith<$Res>  {
  factory $PokemonListStateCopyWith(PokemonListState value, $Res Function(PokemonListState) _then) = _$PokemonListStateCopyWithImpl;
@useResult
$Res call({
 List<Pokemon> pokemonList, bool isLoading, bool isLoadingMore, bool hasMore, int currentOffset, String? errorMessage
});




}
/// @nodoc
class _$PokemonListStateCopyWithImpl<$Res>
    implements $PokemonListStateCopyWith<$Res> {
  _$PokemonListStateCopyWithImpl(this._self, this._then);

  final PokemonListState _self;
  final $Res Function(PokemonListState) _then;

/// Create a copy of PokemonListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pokemonList = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? currentOffset = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
pokemonList: null == pokemonList ? _self.pokemonList : pokemonList // ignore: cast_nullable_to_non_nullable
as List<Pokemon>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentOffset: null == currentOffset ? _self.currentOffset : currentOffset // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonListState].
extension PokemonListStatePatterns on PokemonListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonListState value)  $default,){
final _that = this;
switch (_that) {
case _PokemonListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonListState value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Pokemon> pokemonList,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentOffset,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonListState() when $default != null:
return $default(_that.pokemonList,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentOffset,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Pokemon> pokemonList,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentOffset,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PokemonListState():
return $default(_that.pokemonList,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentOffset,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Pokemon> pokemonList,  bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentOffset,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PokemonListState() when $default != null:
return $default(_that.pokemonList,_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentOffset,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PokemonListState implements PokemonListState {
  const _PokemonListState({final  List<Pokemon> pokemonList = const [], this.isLoading = false, this.isLoadingMore = false, this.hasMore = false, this.currentOffset = 0, this.errorMessage}): _pokemonList = pokemonList;
  

 final  List<Pokemon> _pokemonList;
@override@JsonKey() List<Pokemon> get pokemonList {
  if (_pokemonList is EqualUnmodifiableListView) return _pokemonList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pokemonList);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int currentOffset;
@override final  String? errorMessage;

/// Create a copy of PokemonListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonListStateCopyWith<_PokemonListState> get copyWith => __$PokemonListStateCopyWithImpl<_PokemonListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonListState&&const DeepCollectionEquality().equals(other._pokemonList, _pokemonList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentOffset, currentOffset) || other.currentOffset == currentOffset)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pokemonList),isLoading,isLoadingMore,hasMore,currentOffset,errorMessage);

@override
String toString() {
  return 'PokemonListState(pokemonList: $pokemonList, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentOffset: $currentOffset, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PokemonListStateCopyWith<$Res> implements $PokemonListStateCopyWith<$Res> {
  factory _$PokemonListStateCopyWith(_PokemonListState value, $Res Function(_PokemonListState) _then) = __$PokemonListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Pokemon> pokemonList, bool isLoading, bool isLoadingMore, bool hasMore, int currentOffset, String? errorMessage
});




}
/// @nodoc
class __$PokemonListStateCopyWithImpl<$Res>
    implements _$PokemonListStateCopyWith<$Res> {
  __$PokemonListStateCopyWithImpl(this._self, this._then);

  final _PokemonListState _self;
  final $Res Function(_PokemonListState) _then;

/// Create a copy of PokemonListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pokemonList = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? currentOffset = null,Object? errorMessage = freezed,}) {
  return _then(_PokemonListState(
pokemonList: null == pokemonList ? _self._pokemonList : pokemonList // ignore: cast_nullable_to_non_nullable
as List<Pokemon>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentOffset: null == currentOffset ? _self.currentOffset : currentOffset // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
