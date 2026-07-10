import 'package:flutter/services.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  const PhoneNumberInputFormatter({this.maxDigits = 10});

  final int maxDigits;

  static String formatForDisplay(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return '';
    }

    if (digits.length <= 3) {
      return digits;
    }

    final buffer = StringBuffer('(${digits.substring(0, 3)})');
    var remaining = digits.substring(3);

    while (remaining.length > 4) {
      buffer.write(' ${remaining.substring(0, 3)}');
      remaining = remaining.substring(3);
    }

    if (remaining.length == 4) {
      buffer.write(' ${remaining.substring(0, 2)}');
      buffer.write(' ${remaining.substring(2)}');
    } else if (remaining.isNotEmpty) {
      buffer.write(' $remaining');
    }

    return buffer.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > maxDigits
        ? digits.substring(0, maxDigits)
        : digits;
    final formattedText = formatForDisplay(limitedDigits);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
