import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/auth_login_use_case.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/auth_verify_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase _authLoginUseCase;
  final AuthVerifyUseCase _authVerifyUseCase;
  AuthBloc(this._authLoginUseCase, this._authVerifyUseCase)
    : super(const AuthState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_OtpCodeChanged>(_onOtpCodeChanged);
    on<_SubmitEmail>(_onSubmitEmail);
    on<_SubmitOtp>(_onSubmitOtp);
    on<_BackToEmail>(_onBackToEmail);
  }

  Future<void> _onEmailChanged(
    _EmailChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (state.emailField.value == event.email) {
      return;
    }
    emit(
      state.copyWith(
        emailField: state.emailField.copyWith(
          value: event.email,
          error: null,
          status: FieldStatus.pure,
        ),
      ),
    );
  }

  Future<void> _onOtpCodeChanged(
    _OtpCodeChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (state.otpCodeField.value == event.otpCode) {
      return;
    }
    emit(
      state.copyWith(
        otpCodeField: state.otpCodeField.copyWith(
          value: event.otpCode,
          error: null,
          status: FieldStatus.pure,
        ),
      ),
    );
  }

  Future<void> _onSubmitEmail(
    _SubmitEmail event,
    Emitter<AuthState> emit,
  ) async {
    final email = state.emailField.value?.trim();
    if (email == null || email.isEmpty) {
      return;
    }
    emit(state.copyWith(status: const StateStatus.loading()));
    final result = await _authLoginUseCase(email);
    result.fold(
      (failure) {
        final fieldErrors = failure.details?.fieldErrors;
        final type = failure.details?.type;
        if (type == FailureType.inline && fieldErrors != null) {
          final emailError = _fieldError(fieldErrors, 'email');
          if (emailError != null) {
            emit(
              state.copyWith(
                status: StateStatus.error(failure),
                emailField: state.emailField.copyWith(
                  error: emailError,
                  status: FieldStatus.invalid,
                ),
              ),
            );
            return;
          }
        }
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (data) => emit(
        state.copyWith(
          emailField: state.emailField.copyWith(
            status: FieldStatus.valid,
            error: null,
          ),
          status: const StateStatus.success(),
          step: AuthStep.otp,
          loginRequestId: data.loginRequestId,
        ),
      ),
    );
  }

  Future<void> _onSubmitOtp(_SubmitOtp event, Emitter<AuthState> emit) async {
    final otpCode = state.otpCodeField.value?.trim();
    final email = state.emailField.value?.trim();
    final loginRequestId = state.loginRequestId;
    if (otpCode == null ||
        otpCode.isEmpty ||
        email == null ||
        email.isEmpty ||
        loginRequestId == null) {
      return;
    }
    emit(state.copyWith(status: const StateStatus.loading()));
    final result = await _authVerifyUseCase(
      VerifyRequest(
        loginRequestId: loginRequestId,
        email: email,
        code: otpCode,
      ),
    );
    await result.fold(
      (failure) {
        final fieldErrors = failure.details?.fieldErrors;
        if (failure.details?.type == FailureType.inline &&
            fieldErrors != null) {
          final codeError = _fieldError(fieldErrors, 'code');
          if (codeError == null) {
            emit(state.copyWith(status: StateStatus.error(failure)));
            return;
          }
          emit(
            state.copyWith(
              status: StateStatus.error(failure),
              otpCodeField: state.otpCodeField.copyWith(
                error: codeError,
                status: FieldStatus.invalid,
              ),
            ),
          );
          return;
        }
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (_) {
        emit(
          state.copyWith(
            status: const StateStatus.success(),
            step: AuthStep.success,
          ),
        );
      },
    );
  }

  Future<void> _onBackToEmail(
    _BackToEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        step: AuthStep.email,
        emailField: state.emailField.copyWith(
          error: null,
          status: FieldStatus.pure,
        ),
        otpCodeField: state.otpCodeField.copyWith(
          error: null,
          status: FieldStatus.pure,
        ),
      ),
    );
  }

  String? _fieldError(List<FieldFailure> fieldErrors, String fieldName) {
    for (final error in fieldErrors) {
      if (error.fieldName == fieldName) {
        return error.message;
      }
    }
    return null;
  }
}
