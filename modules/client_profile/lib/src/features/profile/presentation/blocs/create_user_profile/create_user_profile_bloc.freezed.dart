// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_user_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateUserProfileEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent()';
}


}

/// @nodoc
class $CreateUserProfileEventCopyWith<$Res>  {
$CreateUserProfileEventCopyWith(CreateUserProfileEvent _, $Res Function(CreateUserProfileEvent) __);
}



/// @nodoc


class _Started with DiagnosticableTreeMixin implements CreateUserProfileEvent {
  const _Started();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent.started'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent.started()';
}


}




/// @nodoc


class _CountryCodeSelected with DiagnosticableTreeMixin implements CreateUserProfileEvent {
  const _CountryCodeSelected(this.dialCode);
  

 final  CountryDialCode dialCode;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCodeSelectedCopyWith<_CountryCodeSelected> get copyWith => __$CountryCodeSelectedCopyWithImpl<_CountryCodeSelected>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent.countryCodeSelected'))
    ..add(DiagnosticsProperty('dialCode', dialCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountryCodeSelected&&(identical(other.dialCode, dialCode) || other.dialCode == dialCode));
}


@override
int get hashCode => Object.hash(runtimeType,dialCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent.countryCodeSelected(dialCode: $dialCode)';
}


}

/// @nodoc
abstract mixin class _$CountryCodeSelectedCopyWith<$Res> implements $CreateUserProfileEventCopyWith<$Res> {
  factory _$CountryCodeSelectedCopyWith(_CountryCodeSelected value, $Res Function(_CountryCodeSelected) _then) = __$CountryCodeSelectedCopyWithImpl;
@useResult
$Res call({
 CountryDialCode dialCode
});




}
/// @nodoc
class __$CountryCodeSelectedCopyWithImpl<$Res>
    implements _$CountryCodeSelectedCopyWith<$Res> {
  __$CountryCodeSelectedCopyWithImpl(this._self, this._then);

  final _CountryCodeSelected _self;
  final $Res Function(_CountryCodeSelected) _then;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialCode = null,}) {
  return _then(_CountryCodeSelected(
null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as CountryDialCode,
  ));
}


}

/// @nodoc


class _FullNameChanged with DiagnosticableTreeMixin implements CreateUserProfileEvent {
  const _FullNameChanged(this.value);
  

 final  String value;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FullNameChangedCopyWith<_FullNameChanged> get copyWith => __$FullNameChangedCopyWithImpl<_FullNameChanged>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent.fullNameChanged'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FullNameChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent.fullNameChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$FullNameChangedCopyWith<$Res> implements $CreateUserProfileEventCopyWith<$Res> {
  factory _$FullNameChangedCopyWith(_FullNameChanged value, $Res Function(_FullNameChanged) _then) = __$FullNameChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$FullNameChangedCopyWithImpl<$Res>
    implements _$FullNameChangedCopyWith<$Res> {
  __$FullNameChangedCopyWithImpl(this._self, this._then);

  final _FullNameChanged _self;
  final $Res Function(_FullNameChanged) _then;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_FullNameChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PhoneNumberChanged with DiagnosticableTreeMixin implements CreateUserProfileEvent {
  const _PhoneNumberChanged({required this.value});
  

 final  String value;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneNumberChangedCopyWith<_PhoneNumberChanged> get copyWith => __$PhoneNumberChangedCopyWithImpl<_PhoneNumberChanged>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent.phoneNumberChanged'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneNumberChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent.phoneNumberChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PhoneNumberChangedCopyWith<$Res> implements $CreateUserProfileEventCopyWith<$Res> {
  factory _$PhoneNumberChangedCopyWith(_PhoneNumberChanged value, $Res Function(_PhoneNumberChanged) _then) = __$PhoneNumberChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PhoneNumberChangedCopyWithImpl<$Res>
    implements _$PhoneNumberChangedCopyWith<$Res> {
  __$PhoneNumberChangedCopyWithImpl(this._self, this._then);

  final _PhoneNumberChanged _self;
  final $Res Function(_PhoneNumberChanged) _then;

/// Create a copy of CreateUserProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PhoneNumberChanged(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SaveRequested with DiagnosticableTreeMixin implements CreateUserProfileEvent {
  const _SaveRequested();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileEvent.saveRequested'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileEvent.saveRequested()';
}


}




/// @nodoc
mixin _$CreateUserProfileState implements DiagnosticableTreeMixin {

 FieldState<String> get fullName; FieldState<UserPhoneNumber> get phoneNumber; StateStatus get saveStatus;
/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateUserProfileStateCopyWith<CreateUserProfileState> get copyWith => _$CreateUserProfileStateCopyWithImpl<CreateUserProfileState>(this as CreateUserProfileState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileState'))
    ..add(DiagnosticsProperty('fullName', fullName))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('saveStatus', saveStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserProfileState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phoneNumber,saveStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileState(fullName: $fullName, phoneNumber: $phoneNumber, saveStatus: $saveStatus)';
}


}

/// @nodoc
abstract mixin class $CreateUserProfileStateCopyWith<$Res>  {
  factory $CreateUserProfileStateCopyWith(CreateUserProfileState value, $Res Function(CreateUserProfileState) _then) = _$CreateUserProfileStateCopyWithImpl;
@useResult
$Res call({
 FieldState<String> fullName, FieldState<UserPhoneNumber> phoneNumber, StateStatus saveStatus
});


$FieldStateCopyWith<String, $Res> get fullName;$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber;$StateStatusCopyWith<$Res> get saveStatus;

}
/// @nodoc
class _$CreateUserProfileStateCopyWithImpl<$Res>
    implements $CreateUserProfileStateCopyWith<$Res> {
  _$CreateUserProfileStateCopyWithImpl(this._self, this._then);

  final CreateUserProfileState _self;
  final $Res Function(CreateUserProfileState) _then;

/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? phoneNumber = null,Object? saveStatus = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as FieldState<String>,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as FieldState<UserPhoneNumber>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}
/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get fullName {
  
  return $FieldStateCopyWith<String, $Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber {
  
  return $FieldStateCopyWith<UserPhoneNumber, $Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}/// Create a copy of CreateUserProfileState
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


class _CreateUserProfileState with DiagnosticableTreeMixin implements CreateUserProfileState {
  const _CreateUserProfileState({this.fullName = const FieldState<String>(value: ''), this.phoneNumber = const FieldState<UserPhoneNumber>(value: UserPhoneNumber(countryCode: '', dialCode: '', number: '')), this.saveStatus = const StateStatus.initial()});
  

@override@JsonKey() final  FieldState<String> fullName;
@override@JsonKey() final  FieldState<UserPhoneNumber> phoneNumber;
@override@JsonKey() final  StateStatus saveStatus;

/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateUserProfileStateCopyWith<_CreateUserProfileState> get copyWith => __$CreateUserProfileStateCopyWithImpl<_CreateUserProfileState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreateUserProfileState'))
    ..add(DiagnosticsProperty('fullName', fullName))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('saveStatus', saveStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateUserProfileState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phoneNumber,saveStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreateUserProfileState(fullName: $fullName, phoneNumber: $phoneNumber, saveStatus: $saveStatus)';
}


}

/// @nodoc
abstract mixin class _$CreateUserProfileStateCopyWith<$Res> implements $CreateUserProfileStateCopyWith<$Res> {
  factory _$CreateUserProfileStateCopyWith(_CreateUserProfileState value, $Res Function(_CreateUserProfileState) _then) = __$CreateUserProfileStateCopyWithImpl;
@override @useResult
$Res call({
 FieldState<String> fullName, FieldState<UserPhoneNumber> phoneNumber, StateStatus saveStatus
});


@override $FieldStateCopyWith<String, $Res> get fullName;@override $FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber;@override $StateStatusCopyWith<$Res> get saveStatus;

}
/// @nodoc
class __$CreateUserProfileStateCopyWithImpl<$Res>
    implements _$CreateUserProfileStateCopyWith<$Res> {
  __$CreateUserProfileStateCopyWithImpl(this._self, this._then);

  final _CreateUserProfileState _self;
  final $Res Function(_CreateUserProfileState) _then;

/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phoneNumber = null,Object? saveStatus = null,}) {
  return _then(_CreateUserProfileState(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as FieldState<String>,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as FieldState<UserPhoneNumber>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}

/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get fullName {
  
  return $FieldStateCopyWith<String, $Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of CreateUserProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<UserPhoneNumber, $Res> get phoneNumber {
  
  return $FieldStateCopyWith<UserPhoneNumber, $Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}/// Create a copy of CreateUserProfileState
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
