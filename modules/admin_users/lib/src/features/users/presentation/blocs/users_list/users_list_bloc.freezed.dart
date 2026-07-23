// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersListEvent()';
}


}

/// @nodoc
class $UsersListEventCopyWith<$Res>  {
$UsersListEventCopyWith(UsersListEvent _, $Res Function(UsersListEvent) __);
}



/// @nodoc


class _Started implements UsersListEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersListEvent.started()';
}


}




/// @nodoc


class _Refreshed implements UsersListEvent {
  const _Refreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersListEvent.refreshed()';
}


}




/// @nodoc


class _SortChanged implements UsersListEvent {
  const _SortChanged(this.field);
  

 final  UsersSortField field;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SortChangedCopyWith<_SortChanged> get copyWith => __$SortChangedCopyWithImpl<_SortChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SortChanged&&(identical(other.field, field) || other.field == field));
}


@override
int get hashCode => Object.hash(runtimeType,field);

@override
String toString() {
  return 'UsersListEvent.sortChanged(field: $field)';
}


}

/// @nodoc
abstract mixin class _$SortChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$SortChangedCopyWith(_SortChanged value, $Res Function(_SortChanged) _then) = __$SortChangedCopyWithImpl;
@useResult
$Res call({
 UsersSortField field
});




}
/// @nodoc
class __$SortChangedCopyWithImpl<$Res>
    implements _$SortChangedCopyWith<$Res> {
  __$SortChangedCopyWithImpl(this._self, this._then);

  final _SortChanged _self;
  final $Res Function(_SortChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,}) {
  return _then(_SortChanged(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as UsersSortField,
  ));
}


}

/// @nodoc


class _SearchSubmitted implements UsersListEvent {
  const _SearchSubmitted(this.search);
  

 final  String search;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSubmittedCopyWith<_SearchSubmitted> get copyWith => __$SearchSubmittedCopyWithImpl<_SearchSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSubmitted&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'UsersListEvent.searchSubmitted(search: $search)';
}


}

/// @nodoc
abstract mixin class _$SearchSubmittedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$SearchSubmittedCopyWith(_SearchSubmitted value, $Res Function(_SearchSubmitted) _then) = __$SearchSubmittedCopyWithImpl;
@useResult
$Res call({
 String search
});




}
/// @nodoc
class __$SearchSubmittedCopyWithImpl<$Res>
    implements _$SearchSubmittedCopyWith<$Res> {
  __$SearchSubmittedCopyWithImpl(this._self, this._then);

  final _SearchSubmitted _self;
  final $Res Function(_SearchSubmitted) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = null,}) {
  return _then(_SearchSubmitted(
null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StatusChanged implements UsersListEvent {
  const _StatusChanged(this.status);
  

 final  UserStatus? status;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusChangedCopyWith<_StatusChanged> get copyWith => __$StatusChangedCopyWithImpl<_StatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusChanged&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'UsersListEvent.statusChanged(status: $status)';
}


}

/// @nodoc
abstract mixin class _$StatusChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$StatusChangedCopyWith(_StatusChanged value, $Res Function(_StatusChanged) _then) = __$StatusChangedCopyWithImpl;
@useResult
$Res call({
 UserStatus? status
});




}
/// @nodoc
class __$StatusChangedCopyWithImpl<$Res>
    implements _$StatusChangedCopyWith<$Res> {
  __$StatusChangedCopyWithImpl(this._self, this._then);

  final _StatusChanged _self;
  final $Res Function(_StatusChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,}) {
  return _then(_StatusChanged(
freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus?,
  ));
}


}

/// @nodoc


class _RoleChanged implements UsersListEvent {
  const _RoleChanged(this.role);
  

 final  UserRole? role;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleChangedCopyWith<_RoleChanged> get copyWith => __$RoleChangedCopyWithImpl<_RoleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleChanged&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,role);

@override
String toString() {
  return 'UsersListEvent.roleChanged(role: $role)';
}


}

/// @nodoc
abstract mixin class _$RoleChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$RoleChangedCopyWith(_RoleChanged value, $Res Function(_RoleChanged) _then) = __$RoleChangedCopyWithImpl;
@useResult
$Res call({
 UserRole? role
});




}
/// @nodoc
class __$RoleChangedCopyWithImpl<$Res>
    implements _$RoleChangedCopyWith<$Res> {
  __$RoleChangedCopyWithImpl(this._self, this._then);

  final _RoleChanged _self;
  final $Res Function(_RoleChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = freezed,}) {
  return _then(_RoleChanged(
freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole?,
  ));
}


}

/// @nodoc


class _IsVerifiedChanged implements UsersListEvent {
  const _IsVerifiedChanged({this.isVerified});
  

 final  bool? isVerified;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IsVerifiedChangedCopyWith<_IsVerifiedChanged> get copyWith => __$IsVerifiedChangedCopyWithImpl<_IsVerifiedChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IsVerifiedChanged&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,isVerified);

@override
String toString() {
  return 'UsersListEvent.isVerifiedChanged(isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$IsVerifiedChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$IsVerifiedChangedCopyWith(_IsVerifiedChanged value, $Res Function(_IsVerifiedChanged) _then) = __$IsVerifiedChangedCopyWithImpl;
@useResult
$Res call({
 bool? isVerified
});




}
/// @nodoc
class __$IsVerifiedChangedCopyWithImpl<$Res>
    implements _$IsVerifiedChangedCopyWith<$Res> {
  __$IsVerifiedChangedCopyWithImpl(this._self, this._then);

  final _IsVerifiedChanged _self;
  final $Res Function(_IsVerifiedChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isVerified = freezed,}) {
  return _then(_IsVerifiedChanged(
isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class _IsProfileCompletedChanged implements UsersListEvent {
  const _IsProfileCompletedChanged({this.isProfileCompleted});
  

 final  bool? isProfileCompleted;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IsProfileCompletedChangedCopyWith<_IsProfileCompletedChanged> get copyWith => __$IsProfileCompletedChangedCopyWithImpl<_IsProfileCompletedChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IsProfileCompletedChanged&&(identical(other.isProfileCompleted, isProfileCompleted) || other.isProfileCompleted == isProfileCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,isProfileCompleted);

@override
String toString() {
  return 'UsersListEvent.isProfileCompletedChanged(isProfileCompleted: $isProfileCompleted)';
}


}

/// @nodoc
abstract mixin class _$IsProfileCompletedChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$IsProfileCompletedChangedCopyWith(_IsProfileCompletedChanged value, $Res Function(_IsProfileCompletedChanged) _then) = __$IsProfileCompletedChangedCopyWithImpl;
@useResult
$Res call({
 bool? isProfileCompleted
});




}
/// @nodoc
class __$IsProfileCompletedChangedCopyWithImpl<$Res>
    implements _$IsProfileCompletedChangedCopyWith<$Res> {
  __$IsProfileCompletedChangedCopyWithImpl(this._self, this._then);

  final _IsProfileCompletedChanged _self;
  final $Res Function(_IsProfileCompletedChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isProfileCompleted = freezed,}) {
  return _then(_IsProfileCompletedChanged(
isProfileCompleted: freezed == isProfileCompleted ? _self.isProfileCompleted : isProfileCompleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class _CreatedAtRangeChanged implements UsersListEvent {
  const _CreatedAtRangeChanged({this.from, this.to});
  

 final  DateTime? from;
 final  DateTime? to;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedAtRangeChangedCopyWith<_CreatedAtRangeChanged> get copyWith => __$CreatedAtRangeChangedCopyWithImpl<_CreatedAtRangeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedAtRangeChanged&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'UsersListEvent.createdAtRangeChanged(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$CreatedAtRangeChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$CreatedAtRangeChangedCopyWith(_CreatedAtRangeChanged value, $Res Function(_CreatedAtRangeChanged) _then) = __$CreatedAtRangeChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? from, DateTime? to
});




}
/// @nodoc
class __$CreatedAtRangeChangedCopyWithImpl<$Res>
    implements _$CreatedAtRangeChangedCopyWith<$Res> {
  __$CreatedAtRangeChangedCopyWithImpl(this._self, this._then);

  final _CreatedAtRangeChanged _self;
  final $Res Function(_CreatedAtRangeChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,}) {
  return _then(_CreatedAtRangeChanged(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _FiltersChanged implements UsersListEvent {
  const _FiltersChanged(this.query);
  

 final  UsersQuery query;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FiltersChangedCopyWith<_FiltersChanged> get copyWith => __$FiltersChangedCopyWithImpl<_FiltersChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FiltersChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'UsersListEvent.filtersChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$FiltersChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$FiltersChangedCopyWith(_FiltersChanged value, $Res Function(_FiltersChanged) _then) = __$FiltersChangedCopyWithImpl;
@useResult
$Res call({
 UsersQuery query
});




}
/// @nodoc
class __$FiltersChangedCopyWithImpl<$Res>
    implements _$FiltersChangedCopyWith<$Res> {
  __$FiltersChangedCopyWithImpl(this._self, this._then);

  final _FiltersChanged _self;
  final $Res Function(_FiltersChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_FiltersChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as UsersQuery,
  ));
}


}

/// @nodoc


class _PageChanged implements UsersListEvent {
  const _PageChanged(this.pageNumber);
  

 final  int pageNumber;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageChangedCopyWith<_PageChanged> get copyWith => __$PageChangedCopyWithImpl<_PageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageChanged&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}


@override
int get hashCode => Object.hash(runtimeType,pageNumber);

@override
String toString() {
  return 'UsersListEvent.pageChanged(pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class _$PageChangedCopyWith<$Res> implements $UsersListEventCopyWith<$Res> {
  factory _$PageChangedCopyWith(_PageChanged value, $Res Function(_PageChanged) _then) = __$PageChangedCopyWithImpl;
@useResult
$Res call({
 int pageNumber
});




}
/// @nodoc
class __$PageChangedCopyWithImpl<$Res>
    implements _$PageChangedCopyWith<$Res> {
  __$PageChangedCopyWithImpl(this._self, this._then);

  final _PageChanged _self;
  final $Res Function(_PageChanged) _then;

/// Create a copy of UsersListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,}) {
  return _then(_PageChanged(
null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$UsersListState {

 List<User> get users; UsersQuery get query; StateStatus get status; PaginationMeta? get pagination;
/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersListStateCopyWith<UsersListState> get copyWith => _$UsersListStateCopyWithImpl<UsersListState>(this as UsersListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersListState&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(users),query,status,pagination);

@override
String toString() {
  return 'UsersListState(users: $users, query: $query, status: $status, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $UsersListStateCopyWith<$Res>  {
  factory $UsersListStateCopyWith(UsersListState value, $Res Function(UsersListState) _then) = _$UsersListStateCopyWithImpl;
@useResult
$Res call({
 List<User> users, UsersQuery query, StateStatus status, PaginationMeta? pagination
});


$StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$UsersListStateCopyWithImpl<$Res>
    implements $UsersListStateCopyWith<$Res> {
  _$UsersListStateCopyWithImpl(this._self, this._then);

  final UsersListState _self;
  final $Res Function(UsersListState) _then;

/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? query = null,Object? status = null,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<User>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as UsersQuery,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationMeta?,
  ));
}
/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}



/// @nodoc


class _UsersListState implements UsersListState {
  const _UsersListState({final  List<User> users = const <User>[], this.query = const UsersQuery(), this.status = const StateStatus.initial(), this.pagination}): _users = users;
  

 final  List<User> _users;
@override@JsonKey() List<User> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override@JsonKey() final  UsersQuery query;
@override@JsonKey() final  StateStatus status;
@override final  PaginationMeta? pagination;

/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersListStateCopyWith<_UsersListState> get copyWith => __$UsersListStateCopyWithImpl<_UsersListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersListState&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),query,status,pagination);

@override
String toString() {
  return 'UsersListState(users: $users, query: $query, status: $status, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$UsersListStateCopyWith<$Res> implements $UsersListStateCopyWith<$Res> {
  factory _$UsersListStateCopyWith(_UsersListState value, $Res Function(_UsersListState) _then) = __$UsersListStateCopyWithImpl;
@override @useResult
$Res call({
 List<User> users, UsersQuery query, StateStatus status, PaginationMeta? pagination
});


@override $StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$UsersListStateCopyWithImpl<$Res>
    implements _$UsersListStateCopyWith<$Res> {
  __$UsersListStateCopyWithImpl(this._self, this._then);

  final _UsersListState _self;
  final $Res Function(_UsersListState) _then;

/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? query = null,Object? status = null,Object? pagination = freezed,}) {
  return _then(_UsersListState(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<User>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as UsersQuery,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationMeta?,
  ));
}

/// Create a copy of UsersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
