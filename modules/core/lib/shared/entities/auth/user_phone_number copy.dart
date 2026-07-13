import 'package:equatable/equatable.dart';

class UserPhoneNumber extends Equatable {
  final String countryCode;
  final String dialCode;
  final String number;

  const UserPhoneNumber({
    required this.countryCode,
    required this.dialCode,
    required this.number,
  });

  String get displayValue => '$dialCode $number';

  @override
  List<Object?> get props => [countryCode, dialCode, number];
}
