// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfileEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent()';
}


}

/// @nodoc
class $UserProfileEventCopyWith<$Res>  {
$UserProfileEventCopyWith(UserProfileEvent _, $Res Function(UserProfileEvent) __);
}



/// @nodoc


class UserProfileStarted with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileStarted();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.started'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.started()';
}


}




/// @nodoc


class UserProfileProfileLoaded with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileProfileLoaded();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.profileLoaded'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileProfileLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.profileLoaded()';
}


}




/// @nodoc


class UserProfileAvatarUploadRequested with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileAvatarUploadRequested(this.avatar);
  

 final  AppPickedFile avatar;

/// Create a copy of UserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileAvatarUploadRequestedCopyWith<UserProfileAvatarUploadRequested> get copyWith => _$UserProfileAvatarUploadRequestedCopyWithImpl<UserProfileAvatarUploadRequested>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.avatarUploadRequested'))
    ..add(DiagnosticsProperty('avatar', avatar));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileAvatarUploadRequested&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,avatar);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.avatarUploadRequested(avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $UserProfileAvatarUploadRequestedCopyWith<$Res> implements $UserProfileEventCopyWith<$Res> {
  factory $UserProfileAvatarUploadRequestedCopyWith(UserProfileAvatarUploadRequested value, $Res Function(UserProfileAvatarUploadRequested) _then) = _$UserProfileAvatarUploadRequestedCopyWithImpl;
@useResult
$Res call({
 AppPickedFile avatar
});




}
/// @nodoc
class _$UserProfileAvatarUploadRequestedCopyWithImpl<$Res>
    implements $UserProfileAvatarUploadRequestedCopyWith<$Res> {
  _$UserProfileAvatarUploadRequestedCopyWithImpl(this._self, this._then);

  final UserProfileAvatarUploadRequested _self;
  final $Res Function(UserProfileAvatarUploadRequested) _then;

/// Create a copy of UserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? avatar = null,}) {
  return _then(UserProfileAvatarUploadRequested(
null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as AppPickedFile,
  ));
}


}

/// @nodoc


class UserProfileAvatarRemoveRequested with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileAvatarRemoveRequested();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.avatarRemoveRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileAvatarRemoveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.avatarRemoveRequested()';
}


}




/// @nodoc


class UserProfileAvatarStatusReset with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileAvatarStatusReset();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.avatarStatusReset'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileAvatarStatusReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.avatarStatusReset()';
}


}




/// @nodoc


class UserProfileAccountDeletionRequested with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileAccountDeletionRequested();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.accountDeletionRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileAccountDeletionRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.accountDeletionRequested()';
}


}




/// @nodoc


class UserProfileAccountDeletionStatusReset with DiagnosticableTreeMixin implements UserProfileEvent {
  const UserProfileAccountDeletionStatusReset();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEvent.accountDeletionStatusReset'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileAccountDeletionStatusReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEvent.accountDeletionStatusReset()';
}


}




/// @nodoc
mixin _$UserProfileState implements DiagnosticableTreeMixin {

 AppInfo? get appInfo; User? get user; UserProfile? get profile; bool get showAppBuildDetails; StateStatus get status; StateStatus get profileStatus; StateStatus get avatarStatus; StateStatus get accountDeletionStatus; double? get avatarUploadProgress; UserProfileAvatarAction? get avatarAction;
/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileStateCopyWith<UserProfileState> get copyWith => _$UserProfileStateCopyWithImpl<UserProfileState>(this as UserProfileState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileState'))
    ..add(DiagnosticsProperty('appInfo', appInfo))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('profile', profile))..add(DiagnosticsProperty('showAppBuildDetails', showAppBuildDetails))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('profileStatus', profileStatus))..add(DiagnosticsProperty('avatarStatus', avatarStatus))..add(DiagnosticsProperty('accountDeletionStatus', accountDeletionStatus))..add(DiagnosticsProperty('avatarUploadProgress', avatarUploadProgress))..add(DiagnosticsProperty('avatarAction', avatarAction));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileState&&(identical(other.appInfo, appInfo) || other.appInfo == appInfo)&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.showAppBuildDetails, showAppBuildDetails) || other.showAppBuildDetails == showAppBuildDetails)&&(identical(other.status, status) || other.status == status)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.avatarStatus, avatarStatus) || other.avatarStatus == avatarStatus)&&(identical(other.accountDeletionStatus, accountDeletionStatus) || other.accountDeletionStatus == accountDeletionStatus)&&(identical(other.avatarUploadProgress, avatarUploadProgress) || other.avatarUploadProgress == avatarUploadProgress)&&(identical(other.avatarAction, avatarAction) || other.avatarAction == avatarAction));
}


@override
int get hashCode => Object.hash(runtimeType,appInfo,user,profile,showAppBuildDetails,status,profileStatus,avatarStatus,accountDeletionStatus,avatarUploadProgress,avatarAction);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileState(appInfo: $appInfo, user: $user, profile: $profile, showAppBuildDetails: $showAppBuildDetails, status: $status, profileStatus: $profileStatus, avatarStatus: $avatarStatus, accountDeletionStatus: $accountDeletionStatus, avatarUploadProgress: $avatarUploadProgress, avatarAction: $avatarAction)';
}


}

/// @nodoc
abstract mixin class $UserProfileStateCopyWith<$Res>  {
  factory $UserProfileStateCopyWith(UserProfileState value, $Res Function(UserProfileState) _then) = _$UserProfileStateCopyWithImpl;
@useResult
$Res call({
 AppInfo? appInfo, User? user, UserProfile? profile, bool showAppBuildDetails, StateStatus status, StateStatus profileStatus, StateStatus avatarStatus, StateStatus accountDeletionStatus, double? avatarUploadProgress, UserProfileAvatarAction? avatarAction
});


$StateStatusCopyWith<$Res> get status;$StateStatusCopyWith<$Res> get profileStatus;$StateStatusCopyWith<$Res> get avatarStatus;$StateStatusCopyWith<$Res> get accountDeletionStatus;

}
/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._self, this._then);

  final UserProfileState _self;
  final $Res Function(UserProfileState) _then;

/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appInfo = freezed,Object? user = freezed,Object? profile = freezed,Object? showAppBuildDetails = null,Object? status = null,Object? profileStatus = null,Object? avatarStatus = null,Object? accountDeletionStatus = null,Object? avatarUploadProgress = freezed,Object? avatarAction = freezed,}) {
  return _then(_self.copyWith(
appInfo: freezed == appInfo ? _self.appInfo : appInfo // ignore: cast_nullable_to_non_nullable
as AppInfo?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,showAppBuildDetails: null == showAppBuildDetails ? _self.showAppBuildDetails : showAppBuildDetails // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,avatarStatus: null == avatarStatus ? _self.avatarStatus : avatarStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,accountDeletionStatus: null == accountDeletionStatus ? _self.accountDeletionStatus : accountDeletionStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,avatarUploadProgress: freezed == avatarUploadProgress ? _self.avatarUploadProgress : avatarUploadProgress // ignore: cast_nullable_to_non_nullable
as double?,avatarAction: freezed == avatarAction ? _self.avatarAction : avatarAction // ignore: cast_nullable_to_non_nullable
as UserProfileAvatarAction?,
  ));
}
/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get profileStatus {
  
  return $StateStatusCopyWith<$Res>(_self.profileStatus, (value) {
    return _then(_self.copyWith(profileStatus: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get avatarStatus {
  
  return $StateStatusCopyWith<$Res>(_self.avatarStatus, (value) {
    return _then(_self.copyWith(avatarStatus: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get accountDeletionStatus {
  
  return $StateStatusCopyWith<$Res>(_self.accountDeletionStatus, (value) {
    return _then(_self.copyWith(accountDeletionStatus: value));
  });
}
}



/// @nodoc


class _UserProfileState with DiagnosticableTreeMixin implements UserProfileState {
  const _UserProfileState({this.appInfo, this.user, this.profile, this.showAppBuildDetails = false, this.status = const StateStatus.initial(), this.profileStatus = const StateStatus.initial(), this.avatarStatus = const StateStatus.initial(), this.accountDeletionStatus = const StateStatus.initial(), this.avatarUploadProgress, this.avatarAction});
  

@override final  AppInfo? appInfo;
@override final  User? user;
@override final  UserProfile? profile;
@override@JsonKey() final  bool showAppBuildDetails;
@override@JsonKey() final  StateStatus status;
@override@JsonKey() final  StateStatus profileStatus;
@override@JsonKey() final  StateStatus avatarStatus;
@override@JsonKey() final  StateStatus accountDeletionStatus;
@override final  double? avatarUploadProgress;
@override final  UserProfileAvatarAction? avatarAction;

/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileStateCopyWith<_UserProfileState> get copyWith => __$UserProfileStateCopyWithImpl<_UserProfileState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileState'))
    ..add(DiagnosticsProperty('appInfo', appInfo))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('profile', profile))..add(DiagnosticsProperty('showAppBuildDetails', showAppBuildDetails))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('profileStatus', profileStatus))..add(DiagnosticsProperty('avatarStatus', avatarStatus))..add(DiagnosticsProperty('accountDeletionStatus', accountDeletionStatus))..add(DiagnosticsProperty('avatarUploadProgress', avatarUploadProgress))..add(DiagnosticsProperty('avatarAction', avatarAction));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileState&&(identical(other.appInfo, appInfo) || other.appInfo == appInfo)&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.showAppBuildDetails, showAppBuildDetails) || other.showAppBuildDetails == showAppBuildDetails)&&(identical(other.status, status) || other.status == status)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.avatarStatus, avatarStatus) || other.avatarStatus == avatarStatus)&&(identical(other.accountDeletionStatus, accountDeletionStatus) || other.accountDeletionStatus == accountDeletionStatus)&&(identical(other.avatarUploadProgress, avatarUploadProgress) || other.avatarUploadProgress == avatarUploadProgress)&&(identical(other.avatarAction, avatarAction) || other.avatarAction == avatarAction));
}


@override
int get hashCode => Object.hash(runtimeType,appInfo,user,profile,showAppBuildDetails,status,profileStatus,avatarStatus,accountDeletionStatus,avatarUploadProgress,avatarAction);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileState(appInfo: $appInfo, user: $user, profile: $profile, showAppBuildDetails: $showAppBuildDetails, status: $status, profileStatus: $profileStatus, avatarStatus: $avatarStatus, accountDeletionStatus: $accountDeletionStatus, avatarUploadProgress: $avatarUploadProgress, avatarAction: $avatarAction)';
}


}

/// @nodoc
abstract mixin class _$UserProfileStateCopyWith<$Res> implements $UserProfileStateCopyWith<$Res> {
  factory _$UserProfileStateCopyWith(_UserProfileState value, $Res Function(_UserProfileState) _then) = __$UserProfileStateCopyWithImpl;
@override @useResult
$Res call({
 AppInfo? appInfo, User? user, UserProfile? profile, bool showAppBuildDetails, StateStatus status, StateStatus profileStatus, StateStatus avatarStatus, StateStatus accountDeletionStatus, double? avatarUploadProgress, UserProfileAvatarAction? avatarAction
});


@override $StateStatusCopyWith<$Res> get status;@override $StateStatusCopyWith<$Res> get profileStatus;@override $StateStatusCopyWith<$Res> get avatarStatus;@override $StateStatusCopyWith<$Res> get accountDeletionStatus;

}
/// @nodoc
class __$UserProfileStateCopyWithImpl<$Res>
    implements _$UserProfileStateCopyWith<$Res> {
  __$UserProfileStateCopyWithImpl(this._self, this._then);

  final _UserProfileState _self;
  final $Res Function(_UserProfileState) _then;

/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appInfo = freezed,Object? user = freezed,Object? profile = freezed,Object? showAppBuildDetails = null,Object? status = null,Object? profileStatus = null,Object? avatarStatus = null,Object? accountDeletionStatus = null,Object? avatarUploadProgress = freezed,Object? avatarAction = freezed,}) {
  return _then(_UserProfileState(
appInfo: freezed == appInfo ? _self.appInfo : appInfo // ignore: cast_nullable_to_non_nullable
as AppInfo?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,showAppBuildDetails: null == showAppBuildDetails ? _self.showAppBuildDetails : showAppBuildDetails // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,avatarStatus: null == avatarStatus ? _self.avatarStatus : avatarStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,accountDeletionStatus: null == accountDeletionStatus ? _self.accountDeletionStatus : accountDeletionStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,avatarUploadProgress: freezed == avatarUploadProgress ? _self.avatarUploadProgress : avatarUploadProgress // ignore: cast_nullable_to_non_nullable
as double?,avatarAction: freezed == avatarAction ? _self.avatarAction : avatarAction // ignore: cast_nullable_to_non_nullable
as UserProfileAvatarAction?,
  ));
}

/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get profileStatus {
  
  return $StateStatusCopyWith<$Res>(_self.profileStatus, (value) {
    return _then(_self.copyWith(profileStatus: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get avatarStatus {
  
  return $StateStatusCopyWith<$Res>(_self.avatarStatus, (value) {
    return _then(_self.copyWith(avatarStatus: value));
  });
}/// Create a copy of UserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get accountDeletionStatus {
  
  return $StateStatusCopyWith<$Res>(_self.accountDeletionStatus, (value) {
    return _then(_self.copyWith(accountDeletionStatus: value));
  });
}
}

// dart format on
