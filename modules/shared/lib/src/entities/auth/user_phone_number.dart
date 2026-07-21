import 'package:equatable/equatable.dart';

class UserPhoneNumber extends Equatable {
  const UserPhoneNumber({
    required this.countryCode,
    required this.dialCode,
    required this.number,
  });
  final String countryCode;
  final String dialCode;
  final String number;

  String get displayValue => '$dialCode $number';

  @override
  List<Object?> get props => [countryCode, dialCode, number];
}
