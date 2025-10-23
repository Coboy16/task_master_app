// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskEntitie {

 String get id; String get title; String get description; bool get isCompleted; TaskPriority get priority; TaskSource get source; String get userId; DateTime get createdAt; DateTime get updatedAt; String? get firebaseId; bool get synced; bool get deleted;
/// Create a copy of TaskEntitie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskEntitieCopyWith<TaskEntitie> get copyWith => _$TaskEntitieCopyWithImpl<TaskEntitie>(this as TaskEntitie, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskEntitie&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.source, source) || other.source == source)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.firebaseId, firebaseId) || other.firebaseId == firebaseId)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isCompleted,priority,source,userId,createdAt,updatedAt,firebaseId,synced,deleted);

@override
String toString() {
  return 'TaskEntitie(id: $id, title: $title, description: $description, isCompleted: $isCompleted, priority: $priority, source: $source, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, firebaseId: $firebaseId, synced: $synced, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $TaskEntitieCopyWith<$Res>  {
  factory $TaskEntitieCopyWith(TaskEntitie value, $Res Function(TaskEntitie) _then) = _$TaskEntitieCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, bool isCompleted, TaskPriority priority, TaskSource source, String userId, DateTime createdAt, DateTime updatedAt, String? firebaseId, bool synced, bool deleted
});




}
/// @nodoc
class _$TaskEntitieCopyWithImpl<$Res>
    implements $TaskEntitieCopyWith<$Res> {
  _$TaskEntitieCopyWithImpl(this._self, this._then);

  final TaskEntitie _self;
  final $Res Function(TaskEntitie) _then;

/// Create a copy of TaskEntitie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? isCompleted = null,Object? priority = null,Object? source = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? firebaseId = freezed,Object? synced = null,Object? deleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TaskSource,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,firebaseId: freezed == firebaseId ? _self.firebaseId : firebaseId // ignore: cast_nullable_to_non_nullable
as String?,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskEntitie].
extension TaskEntitiePatterns on TaskEntitie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskEntitie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskEntitie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskEntitie value)  $default,){
final _that = this;
switch (_that) {
case _TaskEntitie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskEntitie value)?  $default,){
final _that = this;
switch (_that) {
case _TaskEntitie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool isCompleted,  TaskPriority priority,  TaskSource source,  String userId,  DateTime createdAt,  DateTime updatedAt,  String? firebaseId,  bool synced,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskEntitie() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.priority,_that.source,_that.userId,_that.createdAt,_that.updatedAt,_that.firebaseId,_that.synced,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool isCompleted,  TaskPriority priority,  TaskSource source,  String userId,  DateTime createdAt,  DateTime updatedAt,  String? firebaseId,  bool synced,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _TaskEntitie():
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.priority,_that.source,_that.userId,_that.createdAt,_that.updatedAt,_that.firebaseId,_that.synced,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  bool isCompleted,  TaskPriority priority,  TaskSource source,  String userId,  DateTime createdAt,  DateTime updatedAt,  String? firebaseId,  bool synced,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _TaskEntitie() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.priority,_that.source,_that.userId,_that.createdAt,_that.updatedAt,_that.firebaseId,_that.synced,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _TaskEntitie extends TaskEntitie {
  const _TaskEntitie({required this.id, required this.title, required this.description, required this.isCompleted, required this.priority, required this.source, required this.userId, required this.createdAt, required this.updatedAt, this.firebaseId, this.synced = false, this.deleted = false}): super._();
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  bool isCompleted;
@override final  TaskPriority priority;
@override final  TaskSource source;
@override final  String userId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? firebaseId;
@override@JsonKey() final  bool synced;
@override@JsonKey() final  bool deleted;

/// Create a copy of TaskEntitie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskEntitieCopyWith<_TaskEntitie> get copyWith => __$TaskEntitieCopyWithImpl<_TaskEntitie>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskEntitie&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.source, source) || other.source == source)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.firebaseId, firebaseId) || other.firebaseId == firebaseId)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isCompleted,priority,source,userId,createdAt,updatedAt,firebaseId,synced,deleted);

@override
String toString() {
  return 'TaskEntitie(id: $id, title: $title, description: $description, isCompleted: $isCompleted, priority: $priority, source: $source, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, firebaseId: $firebaseId, synced: $synced, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$TaskEntitieCopyWith<$Res> implements $TaskEntitieCopyWith<$Res> {
  factory _$TaskEntitieCopyWith(_TaskEntitie value, $Res Function(_TaskEntitie) _then) = __$TaskEntitieCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, bool isCompleted, TaskPriority priority, TaskSource source, String userId, DateTime createdAt, DateTime updatedAt, String? firebaseId, bool synced, bool deleted
});




}
/// @nodoc
class __$TaskEntitieCopyWithImpl<$Res>
    implements _$TaskEntitieCopyWith<$Res> {
  __$TaskEntitieCopyWithImpl(this._self, this._then);

  final _TaskEntitie _self;
  final $Res Function(_TaskEntitie) _then;

/// Create a copy of TaskEntitie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? isCompleted = null,Object? priority = null,Object? source = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? firebaseId = freezed,Object? synced = null,Object? deleted = null,}) {
  return _then(_TaskEntitie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TaskSource,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,firebaseId: freezed == firebaseId ? _self.firebaseId : firebaseId // ignore: cast_nullable_to_non_nullable
as String?,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
