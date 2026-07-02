part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(StateStatus.initial()) StateStatus status,
    @Default(FieldState<String?>(value: null)) FieldState<String?> emailField,
    @Default(FieldState<String?>(value: null)) FieldState<String?> otpCodeField,
    @Default(AuthStep.email) AuthStep step,
    String? loginRequestId,
  }) = _AuthState;
}

enum AuthStep { email, otp, success }
