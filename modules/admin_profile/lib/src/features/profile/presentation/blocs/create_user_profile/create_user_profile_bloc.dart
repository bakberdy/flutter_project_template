import 'package:admin_profile/src/common/config/admin_profile_constants.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/create_user_profile_use_case.dart';
import 'package:admin_profile/src/features/profile/presentation/helpers/user_profile_phone_number_validation.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

part 'create_user_profile_bloc.freezed.dart';
part 'create_user_profile_event.dart';
part 'create_user_profile_state.dart';

@injectable
class CreateUserProfileBloc
    extends Bloc<CreateUserProfileEvent, CreateUserProfileState> {

  CreateUserProfileBloc(this._createUserProfileUseCase)
    : super(const CreateUserProfileState()) {
    on<_Started>(_onStarted);
    on<_CountryCodeSelected>(_onCountryCodeSelected);
    on<_FullNameChanged>(_onFullNameChanged);
    on<_PhoneNumberChanged>(_onPhoneNumberChanged);
    on<_SaveRequested>(_onSaveRequested);
  }
  final CreateUserProfileUseCase _createUserProfileUseCase;

  void _onStarted(_Started event, Emitter<CreateUserProfileState> emit) {
    emit(
      state.copyWith(
        phoneNumber: _validatedPhoneNumberField(
          _phoneNumberWithDialCode(state.phoneNumber.value, _phonePrefix()),
          isDirty: false,
        ),
      ),
    );
  }

  void _onCountryCodeSelected(
    _CountryCodeSelected event,
    Emitter<CreateUserProfileState> emit,
  ) {
    final phoneNumber = _phoneNumberWithDialCode(
      state.phoneNumber.value,
      event.dialCode,
    );
    emit(state.copyWith(phoneNumber: _validatedPhoneNumberField(phoneNumber)));
  }

  void _onFullNameChanged(
    _FullNameChanged event,
    Emitter<CreateUserProfileState> emit,
  ) {
    emit(
      state.copyWith(
        fullName: FieldState<String>(
          value: event.value,
          isDirty: true,
          status: event.value.trim().isEmpty
              ? FieldStatus.invalid
              : FieldStatus.valid,
        ),
      ),
    );
  }

  void _onPhoneNumberChanged(
    _PhoneNumberChanged event,
    Emitter<CreateUserProfileState> emit,
  ) {
    final digits = UserProfilePhoneNumberValidation.digitsOnly(event.value);
    final phoneNumber = _phoneNumberWithDigits(state.phoneNumber.value, digits);
    emit(state.copyWith(phoneNumber: _validatedPhoneNumberField(phoneNumber)));
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<CreateUserProfileState> emit,
  ) async {
    if (!state.canSaveChanges) {
      return;
    }

    emit(state.copyWith(saveStatus: const StateStatus.loading()));

    final result = await _createUserProfileUseCase(
      CreateUserProfileParams(
        fullName: state.fullName.value.trim(),
        phoneNumber: state.phoneNumber.value.number.isEmpty
            ? null
            : state.phoneNumber.value,
      ),
    );

    result.fold((failure) => _handleFailure(failure, emit), (_) {
      emit(
        state.copyWith(
          fullName: state.fullName.copyWith(error: null),
          phoneNumber: state.phoneNumber.copyWith(error: null),
          saveStatus: const StateStatus.success(),
        ),
      );
    });
  }

  void _handleFailure(Failure failure, Emitter<CreateUserProfileState> emit) {
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
}
