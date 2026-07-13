import 'package:client_profile/src/common/client_profile_context_x.dart';
import 'package:flutter/widgets.dart';

const userProfilePhoneNumberInvalidFormatError = 'phone_number_invalid_format';
const userProfilePhoneNumberDigitsRequired = 10;

class UserProfilePhoneNumberValidation {
  static final RegExp _e164Pattern = RegExp(r'^\+[1-9]\d{7,14}$');

  static String digitsOnly(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }

  static bool isValid({
    required String? dialCode,
    required String localDigits,
  }) {
    final digits = digitsOnly(localDigits);
    final fullNumber = '${dialCode ?? ''}$digits';
    return digits.length == userProfilePhoneNumberDigitsRequired &&
        _e164Pattern.hasMatch(fullNumber);
  }
}

String? mapPhoneNumberErrorText(BuildContext context, String? errorText) {
  if (errorText == userProfilePhoneNumberInvalidFormatError) {
    return context.l10n.profileEditPhoneNumberInvalidFormatMessage;
  }
  return errorText;
}
