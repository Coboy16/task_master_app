// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskFilterState {

 TaskFilterType get filterType; TaskPriority? get priority; String get searchQuery;
/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFilterStateCopyWith<TaskFilterState> get copyWith => _$TaskFilterStateCopyWithImpl<TaskFilterState>(this as TaskFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFilterState&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,filterType,priority,searchQuery);

@override
String toString() {
  return 'TaskFilterState(filterType: $filterType, priority: $priority, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $TaskFilterStateCopyWith<$Res>  {
  factory $TaskFilterStateCopyWith(TaskFilterState value, $Res Function(TaskFilterState) _then) = _$TaskFilterStateCopyWithImpl;
@useResult
$Res call({
 TaskFilterType filterType, TaskPriority? priority, String searchQuery
});




}
/// @nodoc
class _$TaskFilterStateCopyWithImpl<$Res>
    implements $TaskFilterStateCopyWith<$Res> {
  _$TaskFilterStateCopyWithImpl(this._self, this._then);

  final TaskFilterState _self;
  final $Res Function(TaskFilterState) _then;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filterType = null,Object? priority = freezed,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as TaskFilterType,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskFilterState].
extension TaskFilterStatePatterns on TaskFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFilterState value)  $default,){
final _that = this;
switch (_that) {
case _TaskFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TaskFilterType filterType,  TaskPriority? priority,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
return $default(_that.filterType,_that.priority,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TaskFilterType filterType,  TaskPriority? priority,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _TaskFilterState():
return $default(_that.filterType,_that.priority,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TaskFilterType filterType,  TaskPriority? priority,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
return $default(_that.filterType,_that.priority,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _TaskFilterState implements TaskFilterState {
  const _TaskFilterState({this.filterType = TaskFilterType.all, this.priority, this.searchQuery = ''});
  

@override@JsonKey() final  TaskFilterType filterType;
@override final  TaskPriority? priority;
@override@JsonKey() final  String searchQuery;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFilterStateCopyWith<_TaskFilterState> get copyWith => __$TaskFilterStateCopyWithImpl<_TaskFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFilterState&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,filterType,priority,searchQuery);

@override
String toString() {
  return 'TaskFilterState(filterType: $filterType, priority: $priority, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$TaskFilterStateCopyWith<$Res> implements $TaskFilterStateCopyWith<$Res> {
  factory _$TaskFilterStateCopyWith(_TaskFilterState value, $Res Function(_TaskFilterState) _then) = __$TaskFilterStateCopyWithImpl;
@override @useResult
$Res call({
 TaskFilterType filterType, TaskPriority? priority, String searchQuery
});




}
/// @nodoc
class __$TaskFilterStateCopyWithImpl<$Res>
    implements _$TaskFilterStateCopyWith<$Res> {
  __$TaskFilterStateCopyWithImpl(this._self, this._then);

  final _TaskFilterState _self;
  final $Res Function(_TaskFilterState) _then;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filterType = null,Object? priority = freezed,Object? searchQuery = null,}) {
  return _then(_TaskFilterState(
filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as TaskFilterType,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
