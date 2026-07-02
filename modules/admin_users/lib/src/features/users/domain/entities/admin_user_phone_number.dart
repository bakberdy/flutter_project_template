import 'package:equatable/equatable.dart';

class AdminUserPhoneNumber extends Equatable {
  const AdminUserPhoneNumber({
    this.countryCode,
    required this.dialCode,
    required this.number,
  });

  final String? countryCode;
  final String dialCode;
  final String number;

  @override
  List<Object?> get props => [countryCode, dialCode, number];
}
