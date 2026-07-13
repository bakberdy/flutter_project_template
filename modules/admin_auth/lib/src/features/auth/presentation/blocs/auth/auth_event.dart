part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.emailChanged(String email) = _EmailChanged;
  const factory AuthEvent.otpCodeChanged(String otpCode) = _OtpCodeChanged;
  const factory AuthEvent.submitEmail() = _SubmitEmail;
  const factory AuthEvent.submitOtp() = _SubmitOtp;

  const factory AuthEvent.backToEmail() = _BackToEmail;
}
