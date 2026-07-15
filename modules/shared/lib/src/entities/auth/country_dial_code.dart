import 'package:equatable/equatable.dart';

class CountryDialCode extends Equatable {
  final String countryCode;
  final String dialCode;

  const CountryDialCode({required this.countryCode, required this.dialCode});

  @override
  List<Object?> get props => [countryCode, dialCode];
}
