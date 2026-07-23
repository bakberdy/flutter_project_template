// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEvent {

 String get userId;
/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEventCopyWith<UserEvent> get copyWith => _$UserEventCopyWithImpl<UserEvent>(this as UserEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'UserEvent(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $UserEventCopyWith<$Res>  {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) _then) = _$UserEventCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$UserEventCopyWithImpl<$Res>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._self, this._then);

  final UserEvent _self;
  final $Res Function(UserEvent) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _Started implements UserEvent {
  const _Started(this.userId);
  

@override final  String userId;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'UserEvent.started(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_Started(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeletionApproved implements UserEvent {
  const _DeletionApproved(this.userId);
  

@override final  String userId;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletionApprovedCopyWith<_DeletionApproved> get copyWith => __$DeletionApprovedCopyWithImpl<_DeletionApproved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeletionApproved&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'UserEvent.deletionApproved(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$DeletionApprovedCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$DeletionApprovedCopyWith(_DeletionApproved value, $Res Function(_DeletionApproved) _then) = __$DeletionApprovedCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$DeletionApprovedCopyWithImpl<$Res>
    implements _$DeletionApprovedCopyWith<$Res> {
  __$DeletionApprovedCopyWithImpl(this._self, this._then);

  final _DeletionApproved _self;
  final $Res Function(_DeletionApproved) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_DeletionApproved(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Blocked implements UserEvent {
  const _Blocked(this.userId);
  

@override final  String userId;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockedCopyWith<_Blocked> get copyWith => __$BlockedCopyWithImpl<_Blocked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Blocked&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'UserEvent.blocked(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$BlockedCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$BlockedCopyWith(_Blocked value, $Res Function(_Blocked) _then) = __$BlockedCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$BlockedCopyWithImpl<$Res>
    implements _$BlockedCopyWith<$Res> {
  __$BlockedCopyWithImpl(this._self, this._then);

  final _Blocked _self;
  final $Res Function(_Blocked) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_Blocked(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Unblocked implements UserEvent {
  const _Unblocked(this.userId);
  

@override final  String userId;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnblockedCopyWith<_Unblocked> get copyWith => __$UnblockedCopyWithImpl<_Unblocked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unblocked&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'UserEvent.unblocked(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$UnblockedCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$UnblockedCopyWith(_Unblocked value, $Res Function(_Unblocked) _then) = __$UnblockedCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$UnblockedCopyWithImpl<$Res>
    implements _$UnblockedCopyWith<$Res> {
  __$UnblockedCopyWithImpl(this._self, this._then);

  final _Unblocked _self;
  final $Res Function(_Unblocked) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_Unblocked(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$UserState {

 User? get user; UserProfile? get profile; StateStatus get status; StateStatus get actionStatus;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.status, status) || other.status == status)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,user,profile,status,actionStatus);

@override
String toString() {
  return 'UserState(user: $user, profile: $profile, status: $status, actionStatus: $actionStatus)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 User? user, UserProfile? profile, StateStatus status, StateStatus actionStatus
});


$StateStatusCopyWith<$Res> get status;$StateStatusCopyWith<$Res> get actionStatus;

}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? profile = freezed,Object? status = null,Object? actionStatus = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get actionStatus {
  
  return $StateStatusCopyWith<$Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}
}



/// @nodoc


class _UserState implements UserState {
  const _UserState({this.user, this.profile, this.status = const StateStatus.initial(), this.actionStatus = const StateStatus.initial()});
  

@override final  User? user;
@override final  UserProfile? profile;
@override@JsonKey() final  StateStatus status;
@override@JsonKey() final  StateStatus actionStatus;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.status, status) || other.status == status)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,user,profile,status,actionStatus);

@override
String toString() {
  return 'UserState(user: $user, profile: $profile, status: $status, actionStatus: $actionStatus)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 User? user, UserProfile? profile, StateStatus status, StateStatus actionStatus
});


@override $StateStatusCopyWith<$Res> get status;@override $StateStatusCopyWith<$Res> get actionStatus;

}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? profile = freezed,Object? status = null,Object? actionStatus = null,}) {
  return _then(_UserState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get actionStatus {
  
  return $StateStatusCopyWith<$Res>(_self.actionStatus, (value) {
    return _then(_self.copyWith(actionStatus: value));
  });
}
}

// dart format on
