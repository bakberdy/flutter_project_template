import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:admin_profile/src/common/config/admin_profile_constants.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/update_user_profile_use_case.dart';
import 'package:admin_profile/src/features/profile/presentation/helpers/user_profile_phone_number_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_edit_bloc.freezed.dart';
part 'user_profile_edit_event.dart';
part 'user_profile_edit_state.dart';

@Injectable()
class UserProfileEditBloc
    extends Bloc<UserProfileEditEvent, UserProfileEditState> {
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  UserProfileEditBloc(this._updateUserProfileUseCase)
    : super(const UserProfileEditState()) {
    on<UserProfileEditStarted>(_onStarted);
    on<UserProfileEditCountryCodeSelected>(_onCountryCodeSelected);
    on<UserProfileEditFullNameChanged>(_onFullNameChanged);
    on<UserProfileEditPhoneNumberChanged>(_onPhoneNumberChanged);
    on<UserProfileEditOtpSheetOpened>(_onOtpSheetOpened);
    on<UserProfileEditOtpSubmitted>(_onOtpSubmitted);
    on<UserProfileEditSaveChangesRequested>(_onSaveChangesRequested);
    on<UserProfileEditResetAfterSave>(_onResetAfterSave);
  }

  void _onStarted(
    UserProfileEditStarted event,
    Emitter<UserProfileEditState> emit,
  ) {
    final initialDialCode = _phonePrefix();
    final phoneNumber = event.profile.phoneNumber;
    final resolvedDialCode = phoneNumber == null
        ? initialDialCode
        : AdminProfileConstants.countryDialCodes.firstWhere(
            (code) =>
                code.countryCode == phoneNumber.countryCode ||
                code.dialCode == phoneNumber.dialCode,
            orElse: () => initialDialCode,
          );
    final resolvedPhoneNumber = UserPhoneNumber(
      countryCode: phoneNumber?.countryCode ?? resolvedDialCode.countryCode,
      dialCode: phoneNumber?.dialCode ?? resolvedDialCode.dialCode,
      number: phoneNumber?.number ?? '',
    );
    emit(
      state.copyWith(
        fullName: FieldState<String>(
          value: event.profile.fullName,
          status: FieldStatus.valid,
          error: null,
          isDirty: false,
        ),
        phoneNumber: _validatedPhoneNumberField(
          resolvedPhoneNumber,
          isDirty: false,
        ),
        phoneNumberSaved: UserProfilePhoneNumberValidation.isValid(
          dialCode: resolvedPhoneNumber.dialCode,
          localDigits: resolvedPhoneNumber.number,
        ),
      ),
    );
  }

  void _onCountryCodeSelected(
    UserProfileEditCountryCodeSelected event,
    Emitter<UserProfileEditState> emit,
  ) {
    final phoneNumber = _phoneNumberWithDialCode(
      state.phoneNumber.value,
      event.dialCode,
    );
    emit(
      state.copyWith(
        phoneNumber: _validatedPhoneNumberField(phoneNumber),
        phoneNumberSaved: false,
      ),
    );
  }

  void _onFullNameChanged(
    UserProfileEditFullNameChanged event,
    Emitter<UserProfileEditState> emit,
  ) {
    emit(
      state.copyWith(
        fullName: FieldState<String>(
          value: event.value,
          isDirty: true,
          status: event.value.trim().isEmpty
              ? FieldStatus.invalid
              : FieldStatus.valid,
          error: null,
        ),
      ),
    );
  }

  void _onPhoneNumberChanged(
    UserProfileEditPhoneNumberChanged event,
    Emitter<UserProfileEditState> emit,
  ) {
    final digits = UserProfilePhoneNumberValidation.digitsOnly(event.value);
    final phoneNumber = _phoneNumberWithDigits(state.phoneNumber.value, digits);
    emit(
      state.copyWith(
        phoneNumber: _validatedPhoneNumberField(phoneNumber),
        phoneNumberSaved: false,
      ),
    );
  }

  void _onOtpSheetOpened(
    UserProfileEditOtpSheetOpened event,
    Emitter<UserProfileEditState> emit,
  ) {
    emit(
      state.copyWith(otpStatus: const StateStatus.initial(), otpInvalid: false),
    );
  }

  Future<void> _onOtpSubmitted(
    UserProfileEditOtpSubmitted event,
    Emitter<UserProfileEditState> emit,
  ) async {
    emit(
      state.copyWith(
        otpCode: FieldState<String>(
          value: event.otpCode,
          isDirty: true,
          status: event.otpCode.length == state.otpLength
              ? FieldStatus.valid
              : FieldStatus.invalid,
        ),
        otpStatus: const StateStatus.loading(),
        otpInvalid: false,
      ),
    );
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(
      state.copyWith(otpStatus: const StateStatus.success(), otpInvalid: true),
    );
  }

  Future<void> _onSaveChangesRequested(
    UserProfileEditSaveChangesRequested event,
    Emitter<UserProfileEditState> emit,
  ) async {
    if (!state.canSaveChanges) {
      return;
    }

    final includeFullName = state.fullName.isDirty;
    final includePhoneNumber = state.phoneNumber.isDirty;

    emit(state.copyWith(saveStatus: const StateStatus.loading()));

    final result = await _updateUserProfileUseCase(
      UpdateUserProfileParams(
        fullName: state.fullName.value.trim(),
        phoneNumber: state.phoneNumber.value.number.isEmpty
            ? null
            : state.phoneNumber.value,
        includeFullName: includeFullName,
        includePhoneNumber: includePhoneNumber,
      ),
    );

    result.fold((failure) => _handleSaveFailure(failure, emit), (_) {
      emit(
        state.copyWith(
          fullName: state.fullName.copyWith(error: null),
          phoneNumber: state.phoneNumber.copyWith(error: null),
          phoneNumberSaved:
              (includePhoneNumber && state.phoneNumberComplete) ||
              (!includePhoneNumber && state.phoneNumberSaved),
          saveStatus: const StateStatus.success(),
        ),
      );
    });
  }

  void _handleSaveFailure(Failure failure, Emitter<UserProfileEditState> emit) {
    final fieldErrors = failure.details?.fieldErrors;
    if (failure.details?.type == FailureType.inline &&
        fieldErrors != null &&
        fieldErrors.isNotEmpty) {
      final fullNameError = _fieldError(fieldErrors, const {'full_name'});
      final phoneNumberError = _fieldError(fieldErrors, const {'phone_number'});

      emit(
        state.copyWith(
          fullName: fullNameError == null
              ? state.fullName
              : state.fullName.copyWith(
                  error: fullNameError,
                  status: FieldStatus.invalid,
                ),
          phoneNumber: phoneNumberError == null
              ? state.phoneNumber
              : state.phoneNumber.copyWith(
                  error: phoneNumberError,
                  status: FieldStatus.invalid,
                ),
          saveStatus: StateStatus.error(failure),
        ),
      );
      return;
    }

    emit(state.copyWith(saveStatus: StateStatus.error(failure)));
  }

  String? _fieldError(List<FieldFailure> fieldErrors, Set<String> names) {
    for (final error in fieldErrors) {
      if (names.contains(error.fieldName)) {
        return error.message;
      }
    }
    return null;
  }

  CountryDialCode _phonePrefix() {
    final locale = PlatformDispatcher.instance.locale;
    final countryCode = locale.countryCode?.toUpperCase();
    return AdminProfileConstants.countryDialCodes.firstWhere(
      (e) => e.countryCode == countryCode,
      orElse: () => AdminProfileConstants.countryDialCodes.last,
    );
  }

  UserPhoneNumber _phoneNumberWithDialCode(
    UserPhoneNumber phoneNumber,
    CountryDialCode dialCode,
  ) {
    return UserPhoneNumber(
      countryCode: dialCode.countryCode,
      dialCode: dialCode.dialCode,
      number: phoneNumber.number,
    );
  }

  UserPhoneNumber _phoneNumberWithDigits(
    UserPhoneNumber phoneNumber,
    String digits,
  ) {
    return UserPhoneNumber(
      countryCode: phoneNumber.countryCode,
      dialCode: phoneNumber.dialCode,
      number: digits,
    );
  }

  FieldState<UserPhoneNumber> _validatedPhoneNumberField(
    UserPhoneNumber phoneNumber, {
    bool isDirty = true,
  }) {
    final complete = UserProfilePhoneNumberValidation.isValid(
      dialCode: phoneNumber.dialCode,
      localDigits: phoneNumber.number,
    );
    return FieldState<UserPhoneNumber>(
      value: phoneNumber,
      isDirty: isDirty,
      status: phoneNumber.number.isEmpty
          ? FieldStatus.pure
          : complete
          ? FieldStatus.valid
          : FieldStatus.invalid,
      error: phoneNumber.number.isEmpty || complete
          ? null
          : userProfilePhoneNumberInvalidFormatError,
    );
  }

  void _onResetAfterSave(
    UserProfileEditResetAfterSave event,
    Emitter<UserProfileEditState> emit,
  ) {
    emit(
      state.copyWith(
        fullName: state.fullName.copyWith(
          error: null,
          isDirty: false,
          status: FieldStatus.valid,
        ),
        phoneNumber: state.phoneNumber.copyWith(
          error: null,
          isDirty: false,
          status: state.phoneNumber.value.number.isEmpty
              ? FieldStatus.pure
              : state.phoneNumberComplete
              ? FieldStatus.valid
              : FieldStatus.invalid,
        ),
        otpCode: const FieldState<String>(value: ''),
        otpStatus: const StateStatus.initial(),
        saveStatus: const StateStatus.initial(),
        phoneNumberSaved: state.phoneNumberComplete,
        otpInvalid: false,
      ),
    );
  }
}
