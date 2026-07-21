import 'package:equatable/equatable.dart';

class AdminUserPhoneNumber extends Equatable {
  const AdminUserPhoneNumber({
    required this.dialCode,
    required this.number,
    this.countryCode,
  });

  final String? countryCode;
  final String dialCode;
  final String number;

  @override
  List<Object?> get props => [countryCode, dialCode, number];
}
