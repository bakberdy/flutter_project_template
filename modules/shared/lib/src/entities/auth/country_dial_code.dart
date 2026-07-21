import 'package:equatable/equatable.dart';

class CountryDialCode extends Equatable {
  const CountryDialCode({required this.countryCode, required this.dialCode});
  final String countryCode;
  final String dialCode;

  @override
  List<Object?> get props => [countryCode, dialCode];
}
