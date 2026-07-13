// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_edit_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfileEditEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent()';
}


}

/// @nodoc
class $UserProfileEditEventCopyWith<$Res>  {
$UserProfileEditEventCopyWith(UserProfileEditEvent _, $Res Function(UserProfileEditEvent) __);
}



/// @nodoc


class UserProfileEditStarted with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditStarted(this.profile);
  

 final  UserProfile profile;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditStartedCopyWith<UserProfileEditStarted> get copyWith => _$UserProfileEditStartedCopyWithImpl<UserProfileEditStarted>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.started'))
    ..add(DiagnosticsProperty('profile', profile));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditStarted&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.started(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditStartedCopyWith<$Res> implements $UserProfileEditEventCopyWith<$Res> {
  factory $UserProfileEditStartedCopyWith(UserProfileEditStarted value, $Res Function(UserProfileEditStarted) _then) = _$UserProfileEditStartedCopyWithImpl;
@useResult
$Res call({
 UserProfile profile
});




}
/// @nodoc
class _$UserProfileEditStartedCopyWithImpl<$Res>
    implements $UserProfileEditStartedCopyWith<$Res> {
  _$UserProfileEditStartedCopyWithImpl(this._self, this._then);

  final UserProfileEditStarted _self;
  final $Res Function(UserProfileEditStarted) _then;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(UserProfileEditStarted(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}


}

/// @nodoc


class UserProfileEditCountryCodeSelected with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditCountryCodeSelected(this.dialCode);
  

 final  CountryDialCode dialCode;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditCountryCodeSelectedCopyWith<UserProfileEditCountryCodeSelected> get copyWith => _$UserProfileEditCountryCodeSelectedCopyWithImpl<UserProfileEditCountryCodeSelected>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.countryCodeSelected'))
    ..add(DiagnosticsProperty('dialCode', dialCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditCountryCodeSelected&&(identical(other.dialCode, dialCode) || other.dialCode == dialCode));
}


@override
int get hashCode => Object.hash(runtimeType,dialCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.countryCodeSelected(dialCode: $dialCode)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditCountryCodeSelectedCopyWith<$Res> implements $UserProfileEditEventCopyWith<$Res> {
  factory $UserProfileEditCountryCodeSelectedCopyWith(UserProfileEditCountryCodeSelected value, $Res Function(UserProfileEditCountryCodeSelected) _then) = _$UserProfileEditCountryCodeSelectedCopyWithImpl;
@useResult
$Res call({
 CountryDialCode dialCode
});




}
/// @nodoc
class _$UserProfileEditCountryCodeSelectedCopyWithImpl<$Res>
    implements $UserProfileEditCountryCodeSelectedCopyWith<$Res> {
  _$UserProfileEditCountryCodeSelectedCopyWithImpl(this._self, this._then);

  final UserProfileEditCountryCodeSelected _self;
  final $Res Function(UserProfileEditCountryCodeSelected) _then;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialCode = null,}) {
  return _then(UserProfileEditCountryCodeSelected(
null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as CountryDialCode,
  ));
}


}

/// @nodoc


class UserProfileEditFullNameChanged with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditFullNameChanged(this.value);
  

 final  String value;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditFullNameChangedCopyWith<UserProfileEditFullNameChanged> get copyWith => _$UserProfileEditFullNameChangedCopyWithImpl<UserProfileEditFullNameChanged>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.fullNameChanged'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditFullNameChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.fullNameChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditFullNameChangedCopyWith<$Res> implements $UserProfileEditEventCopyWith<$Res> {
  factory $UserProfileEditFullNameChangedCopyWith(UserProfileEditFullNameChanged value, $Res Function(UserProfileEditFullNameChanged) _then) = _$UserProfileEditFullNameChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$UserProfileEditFullNameChangedCopyWithImpl<$Res>
    implements $UserProfileEditFullNameChangedCopyWith<$Res> {
  _$UserProfileEditFullNameChangedCopyWithImpl(this._self, this._then);

  final UserProfileEditFullNameChanged _self;
  final $Res Function(UserProfileEditFullNameChanged) _then;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(UserProfileEditFullNameChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UserProfileEditPhoneNumberChanged with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditPhoneNumberChanged({required this.value});
  

 final  String value;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditPhoneNumberChangedCopyWith<UserProfileEditPhoneNumberChanged> get copyWith => _$UserProfileEditPhoneNumberChangedCopyWithImpl<UserProfileEditPhoneNumberChanged>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.phoneNumberChanged'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditPhoneNumberChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.phoneNumberChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditPhoneNumberChangedCopyWith<$Res> implements $UserProfileEditEventCopyWith<$Res> {
  factory $UserProfileEditPhoneNumberChangedCopyWith(UserProfileEditPhoneNumberChanged value, $Res Function(UserProfileEditPhoneNumberChanged) _then) = _$UserProfileEditPhoneNumberChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$UserProfileEditPhoneNumberChangedCopyWithImpl<$Res>
    implements $UserProfileEditPhoneNumberChangedCopyWith<$Res> {
  _$UserProfileEditPhoneNumberChangedCopyWithImpl(this._self, this._then);

  final UserProfileEditPhoneNumberChanged _self;
  final $Res Function(UserProfileEditPhoneNumberChanged) _then;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(UserProfileEditPhoneNumberChanged(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UserProfileEditOtpSheetOpened with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditOtpSheetOpened();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.otpSheetOpened'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditOtpSheetOpened);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.otpSheetOpened()';
}


}




/// @nodoc


class UserProfileEditOtpSubmitted with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditOtpSubmitted(this.otpCode);
  

 final  String otpCode;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditOtpSubmittedCopyWith<UserProfileEditOtpSubmitted> get copyWith => _$UserProfileEditOtpSubmittedCopyWithImpl<UserProfileEditOtpSubmitted>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.otpSubmitted'))
    ..add(DiagnosticsProperty('otpCode', otpCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditOtpSubmitted&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}


@override
int get hashCode => Object.hash(runtimeType,otpCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.otpSubmitted(otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditOtpSubmittedCopyWith<$Res> implements $UserProfileEditEventCopyWith<$Res> {
  factory $UserProfileEditOtpSubmittedCopyWith(UserProfileEditOtpSubmitted value, $Res Function(UserProfileEditOtpSubmitted) _then) = _$UserProfileEditOtpSubmittedCopyWithImpl;
@useResult
$Res call({
 String otpCode
});




}
/// @nodoc
class _$UserProfileEditOtpSubmittedCopyWithImpl<$Res>
    implements $UserProfileEditOtpSubmittedCopyWith<$Res> {
  _$UserProfileEditOtpSubmittedCopyWithImpl(this._self, this._then);

  final UserProfileEditOtpSubmitted _self;
  final $Res Function(UserProfileEditOtpSubmitted) _then;

/// Create a copy of UserProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otpCode = null,}) {
  return _then(UserProfileEditOtpSubmitted(
null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UserProfileEditSaveChangesRequested with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditSaveChangesRequested();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.saveChangesRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditSaveChangesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.saveChangesRequested()';
}


}




/// @nodoc


class UserProfileEditResetAfterSave with DiagnosticableTreeMixin implements UserProfileEditEvent {
  const UserProfileEditResetAfterSave();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditEvent.resetAfterSave'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditResetAfterSave);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditEvent.resetAfterSave()';
}


}




/// @nodoc
mixin _$UserProfileEditState implements DiagnosticableTreeMixin {

 FieldState<String> get fullName; FieldState<UserPhoneNumber> get phoneNumber; FieldState<String> get otpCode; int get otpLength; StateStatus get otpStatus; StateStatus get saveStatus; bool get phoneNumberSaved; bool get otpInvalid;
/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileEditStateCopyWith<UserProfileEditState> get copyWith => _$UserProfileEditStateCopyWithImpl<UserProfileEditState>(this as UserProfileEditState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditState'))
    ..add(DiagnosticsProperty('fullName', fullName))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('otpCode', otpCode))..add(DiagnosticsProperty('otpLength', otpLength))..add(DiagnosticsProperty('otpStatus', otpStatus))..add(DiagnosticsProperty('saveStatus', saveStatus))..add(DiagnosticsProperty('phoneNumberSaved', phoneNumberSaved))..add(DiagnosticsProperty('otpInvalid', otpInvalid));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileEditState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.otpLength, otpLength) || other.otpLength == otpLength)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.phoneNumberSaved, phoneNumberSaved) || other.phoneNumberSaved == phoneNumberSaved)&&(identical(other.otpInvalid, otpInvalid) || other.otpInvalid == otpInvalid));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phoneNumber,otpCode,otpLength,otpStatus,saveStatus,phoneNumberSaved,otpInvalid);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditState(fullName: $fullName, phoneNumber: $phoneNumber, otpCode: $otpCode, otpLength: $otpLength, otpStatus: $otpStatus, saveStatus: $saveStatus, phoneNumberSaved: $phoneNumberSaved, otpInvalid: $otpInvalid)';
}


}

/// @nodoc
abstract mixin class $UserProfileEditStateCopyWith<$Res>  {
  factory $UserProfileEditStateCopyWith(UserProfileEditState value, $Res Function(UserProfileEditState) _then) = _$UserProfileEditStateCopyWithImpl;
@useResult
$Res call({
 FieldState<String> fullName, FieldState<UserPhoneNumber> phoneNumber, FieldState<String> otpCode, int otpLength, StateStatus otpStatus, StateStatus saveStatus, bool phoneNumberSaved, bool otpInvalid
});


$FieldStateCopyWith<String, $Res> get fullName;$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber;$FieldStateCopyWith<String, $Res> get otpCode;$StateStatusCopyWith<$Res> get otpStatus;$StateStatusCopyWith<$Res> get saveStatus;

}
/// @nodoc
class _$UserProfileEditStateCopyWithImpl<$Res>
    implements $UserProfileEditStateCopyWith<$Res> {
  _$UserProfileEditStateCopyWithImpl(this._self, this._then);

  final UserProfileEditState _self;
  final $Res Function(UserProfileEditState) _then;

/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? phoneNumber = null,Object? otpCode = null,Object? otpLength = null,Object? otpStatus = null,Object? saveStatus = null,Object? phoneNumberSaved = null,Object? otpInvalid = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as FieldState<String>,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as FieldState<UserPhoneNumber>,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as FieldState<String>,otpLength: null == otpLength ? _self.otpLength : otpLength // ignore: cast_nullable_to_non_nullable
as int,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,phoneNumberSaved: null == phoneNumberSaved ? _self.phoneNumberSaved : phoneNumberSaved // ignore: cast_nullable_to_non_nullable
as bool,otpInvalid: null == otpInvalid ? _self.otpInvalid : otpInvalid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get fullName {
  
  return $FieldStateCopyWith<String, $Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber {
  
  return $FieldStateCopyWith<UserPhoneNumber, $Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get otpCode {
  
  return $FieldStateCopyWith<String, $Res>(_self.otpCode, (value) {
    return _then(_self.copyWith(otpCode: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get otpStatus {
  
  return $StateStatusCopyWith<$Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get saveStatus {
  
  return $StateStatusCopyWith<$Res>(_self.saveStatus, (value) {
    return _then(_self.copyWith(saveStatus: value));
  });
}
}



/// @nodoc


class _UserProfileEditState with DiagnosticableTreeMixin implements UserProfileEditState {
  const _UserProfileEditState({this.fullName = const FieldState<String>(value: ''), this.phoneNumber = const FieldState<UserPhoneNumber>(value: UserPhoneNumber(countryCode: '', dialCode: '', number: '')), this.otpCode = const FieldState<String>(value: ''), this.otpLength = 6, this.otpStatus = const StateStatus.initial(), this.saveStatus = const StateStatus.initial(), this.phoneNumberSaved = false, this.otpInvalid = false});
  

@override@JsonKey() final  FieldState<String> fullName;
@override@JsonKey() final  FieldState<UserPhoneNumber> phoneNumber;
@override@JsonKey() final  FieldState<String> otpCode;
@override@JsonKey() final  int otpLength;
@override@JsonKey() final  StateStatus otpStatus;
@override@JsonKey() final  StateStatus saveStatus;
@override@JsonKey() final  bool phoneNumberSaved;
@override@JsonKey() final  bool otpInvalid;

/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileEditStateCopyWith<_UserProfileEditState> get copyWith => __$UserProfileEditStateCopyWithImpl<_UserProfileEditState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserProfileEditState'))
    ..add(DiagnosticsProperty('fullName', fullName))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('otpCode', otpCode))..add(DiagnosticsProperty('otpLength', otpLength))..add(DiagnosticsProperty('otpStatus', otpStatus))..add(DiagnosticsProperty('saveStatus', saveStatus))..add(DiagnosticsProperty('phoneNumberSaved', phoneNumberSaved))..add(DiagnosticsProperty('otpInvalid', otpInvalid));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileEditState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.otpLength, otpLength) || other.otpLength == otpLength)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.phoneNumberSaved, phoneNumberSaved) || other.phoneNumberSaved == phoneNumberSaved)&&(identical(other.otpInvalid, otpInvalid) || other.otpInvalid == otpInvalid));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phoneNumber,otpCode,otpLength,otpStatus,saveStatus,phoneNumberSaved,otpInvalid);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserProfileEditState(fullName: $fullName, phoneNumber: $phoneNumber, otpCode: $otpCode, otpLength: $otpLength, otpStatus: $otpStatus, saveStatus: $saveStatus, phoneNumberSaved: $phoneNumberSaved, otpInvalid: $otpInvalid)';
}


}

/// @nodoc
abstract mixin class _$UserProfileEditStateCopyWith<$Res> implements $UserProfileEditStateCopyWith<$Res> {
  factory _$UserProfileEditStateCopyWith(_UserProfileEditState value, $Res Function(_UserProfileEditState) _then) = __$UserProfileEditStateCopyWithImpl;
@override @useResult
$Res call({
 FieldState<String> fullName, FieldState<UserPhoneNumber> phoneNumber, FieldState<String> otpCode, int otpLength, StateStatus otpStatus, StateStatus saveStatus, bool phoneNumberSaved, bool otpInvalid
});


@override $FieldStateCopyWith<String, $Res> get fullName;@override $FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber;@override $FieldStateCopyWith<String, $Res> get otpCode;@override $StateStatusCopyWith<$Res> get otpStatus;@override $StateStatusCopyWith<$Res> get saveStatus;

}
/// @nodoc
class __$UserProfileEditStateCopyWithImpl<$Res>
    implements _$UserProfileEditStateCopyWith<$Res> {
  __$UserProfileEditStateCopyWithImpl(this._self, this._then);

  final _UserProfileEditState _self;
  final $Res Function(_UserProfileEditState) _then;

/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phoneNumber = null,Object? otpCode = null,Object? otpLength = null,Object? otpStatus = null,Object? saveStatus = null,Object? phoneNumberSaved = null,Object? otpInvalid = null,}) {
  return _then(_UserProfileEditState(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as FieldState<String>,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as FieldState<UserPhoneNumber>,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as FieldState<String>,otpLength: null == otpLength ? _self.otpLength : otpLength // ignore: cast_nullable_to_non_nullable
as int,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,phoneNumberSaved: null == phoneNumberSaved ? _self.phoneNumberSaved : phoneNumberSaved // ignore: cast_nullable_to_non_nullable
as bool,otpInvalid: null == otpInvalid ? _self.otpInvalid : otpInvalid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get fullName {
  
  return $FieldStateCopyWith<String, $Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber {
  
  return $FieldStateCopyWith<UserPhoneNumber, $Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get otpCode {
  
  return $FieldStateCopyWith<String, $Res>(_self.otpCode, (value) {
    return _then(_self.copyWith(otpCode: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get otpStatus {
  
  return $StateStatusCopyWith<$Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of UserProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get saveStatus {
  
  return $StateStatusCopyWith<$Res>(_self.saveStatus, (value) {
    return _then(_self.copyWith(saveStatus: value));
  });
}
}

// dart format on
