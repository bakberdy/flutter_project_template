// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}



/// @nodoc


class _EmailChanged implements AuthEvent {
  const _EmailChanged(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailChangedCopyWith<_EmailChanged> get copyWith => __$EmailChangedCopyWithImpl<_EmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EmailChangedCopyWith(_EmailChanged value, $Res Function(_EmailChanged) _then) = __$EmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailChangedCopyWithImpl<$Res>
    implements _$EmailChangedCopyWith<$Res> {
  __$EmailChangedCopyWithImpl(this._self, this._then);

  final _EmailChanged _self;
  final $Res Function(_EmailChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OtpCodeChanged implements AuthEvent {
  const _OtpCodeChanged(this.otpCode);
  

 final  String otpCode;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpCodeChangedCopyWith<_OtpCodeChanged> get copyWith => __$OtpCodeChangedCopyWithImpl<_OtpCodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpCodeChanged&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}


@override
int get hashCode => Object.hash(runtimeType,otpCode);

@override
String toString() {
  return 'AuthEvent.otpCodeChanged(otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class _$OtpCodeChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$OtpCodeChangedCopyWith(_OtpCodeChanged value, $Res Function(_OtpCodeChanged) _then) = __$OtpCodeChangedCopyWithImpl;
@useResult
$Res call({
 String otpCode
});




}
/// @nodoc
class __$OtpCodeChangedCopyWithImpl<$Res>
    implements _$OtpCodeChangedCopyWith<$Res> {
  __$OtpCodeChangedCopyWithImpl(this._self, this._then);

  final _OtpCodeChanged _self;
  final $Res Function(_OtpCodeChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otpCode = null,}) {
  return _then(_OtpCodeChanged(
null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SubmitEmail implements AuthEvent {
  const _SubmitEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.submitEmail()';
}


}




/// @nodoc


class _SubmitOtp implements AuthEvent {
  const _SubmitOtp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitOtp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.submitOtp()';
}


}




/// @nodoc


class _BackToEmail implements AuthEvent {
  const _BackToEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackToEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.backToEmail()';
}


}




/// @nodoc
mixin _$AuthState {

 StateStatus get status; FieldState<String?> get emailField; FieldState<String?> get otpCodeField; AuthStep get step; String? get loginRequestId;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.emailField, emailField) || other.emailField == emailField)&&(identical(other.otpCodeField, otpCodeField) || other.otpCodeField == otpCodeField)&&(identical(other.step, step) || other.step == step)&&(identical(other.loginRequestId, loginRequestId) || other.loginRequestId == loginRequestId));
}


@override
int get hashCode => Object.hash(runtimeType,status,emailField,otpCodeField,step,loginRequestId);

@override
String toString() {
  return 'AuthState(status: $status, emailField: $emailField, otpCodeField: $otpCodeField, step: $step, loginRequestId: $loginRequestId)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 StateStatus status, FieldState<String?> emailField, FieldState<String?> otpCodeField, AuthStep step, String? loginRequestId
});


$StateStatusCopyWith<$Res> get status;$FieldStateCopyWith<String?, $Res> get emailField;$FieldStateCopyWith<String?, $Res> get otpCodeField;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? emailField = null,Object? otpCodeField = null,Object? step = null,Object? loginRequestId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,emailField: null == emailField ? _self.emailField : emailField // ignore: cast_nullable_to_non_nullable
as FieldState<String?>,otpCodeField: null == otpCodeField ? _self.otpCodeField : otpCodeField // ignore: cast_nullable_to_non_nullable
as FieldState<String?>,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as AuthStep,loginRequestId: freezed == loginRequestId ? _self.loginRequestId : loginRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String?, $Res> get emailField {
  
  return $FieldStateCopyWith<String?, $Res>(_self.emailField, (value) {
    return _then(_self.copyWith(emailField: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String?, $Res> get otpCodeField {
  
  return $FieldStateCopyWith<String?, $Res>(_self.otpCodeField, (value) {
    return _then(_self.copyWith(otpCodeField: value));
  });
}
}



/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.status = const StateStatus.initial(), this.emailField = const FieldState<String?>(value: null), this.otpCodeField = const FieldState<String?>(value: null), this.step = AuthStep.email, this.loginRequestId});
  

@override@JsonKey() final  StateStatus status;
@override@JsonKey() final  FieldState<String?> emailField;
@override@JsonKey() final  FieldState<String?> otpCodeField;
@override@JsonKey() final  AuthStep step;
@override final  String? loginRequestId;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.emailField, emailField) || other.emailField == emailField)&&(identical(other.otpCodeField, otpCodeField) || other.otpCodeField == otpCodeField)&&(identical(other.step, step) || other.step == step)&&(identical(other.loginRequestId, loginRequestId) || other.loginRequestId == loginRequestId));
}


@override
int get hashCode => Object.hash(runtimeType,status,emailField,otpCodeField,step,loginRequestId);

@override
String toString() {
  return 'AuthState(status: $status, emailField: $emailField, otpCodeField: $otpCodeField, step: $step, loginRequestId: $loginRequestId)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 StateStatus status, FieldState<String?> emailField, FieldState<String?> otpCodeField, AuthStep step, String? loginRequestId
});


@override $StateStatusCopyWith<$Res> get status;@override $FieldStateCopyWith<String?, $Res> get emailField;@override $FieldStateCopyWith<String?, $Res> get otpCodeField;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? emailField = null,Object? otpCodeField = null,Object? step = null,Object? loginRequestId = freezed,}) {
  return _then(_AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,emailField: null == emailField ? _self.emailField : emailField // ignore: cast_nullable_to_non_nullable
as FieldState<String?>,otpCodeField: null == otpCodeField ? _self.otpCodeField : otpCodeField // ignore: cast_nullable_to_non_nullable
as FieldState<String?>,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as AuthStep,loginRequestId: freezed == loginRequestId ? _self.loginRequestId : loginRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String?, $Res> get emailField {
  
  return $FieldStateCopyWith<String?, $Res>(_self.emailField, (value) {
    return _then(_self.copyWith(emailField: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String?, $Res> get otpCodeField {
  
  return $FieldStateCopyWith<String?, $Res>(_self.otpCodeField, (value) {
    return _then(_self.copyWith(otpCodeField: value));
  });
}
}

// dart format on
