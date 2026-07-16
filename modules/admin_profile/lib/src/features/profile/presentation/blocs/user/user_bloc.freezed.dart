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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent()';
}


}





/// @nodoc


class UserRefreshEvent implements UserEvent {
  const UserRefreshEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRefreshEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.refreshUser()';
}


}




/// @nodoc


class UserLoggedOutEvent implements UserEvent {
  const UserLoggedOutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoggedOutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.logout()';
}


}




/// @nodoc


class UserAccessDeniedAcknowledgedEvent implements UserEvent {
  const UserAccessDeniedAcknowledgedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAccessDeniedAcknowledgedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.accessDeniedAcknowledged()';
}


}




/// @nodoc
mixin _$UserState {

 User? get user; bool get accessDenied; StateStatus get status;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.user, user) || other.user == user)&&(identical(other.accessDenied, accessDenied) || other.accessDenied == accessDenied)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessDenied,status);

@override
String toString() {
  return 'UserState(user: $user, accessDenied: $accessDenied, status: $status)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 User? user, bool accessDenied, StateStatus status
});


$StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? accessDenied = null,Object? status = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,accessDenied: null == accessDenied ? _self.accessDenied : accessDenied // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
}
}



/// @nodoc


class _UserState implements UserState {
  const _UserState({this.user, this.accessDenied = false, this.status = const StateStatus.initial()});
  

@override final  User? user;
@override@JsonKey() final  bool accessDenied;
@override@JsonKey() final  StateStatus status;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.user, user) || other.user == user)&&(identical(other.accessDenied, accessDenied) || other.accessDenied == accessDenied)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessDenied,status);

@override
String toString() {
  return 'UserState(user: $user, accessDenied: $accessDenied, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 User? user, bool accessDenied, StateStatus status
});


@override $StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? accessDenied = null,Object? status = null,}) {
  return _then(_UserState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,accessDenied: null == accessDenied ? _self.accessDenied : accessDenied // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
}
}

// dart format on
