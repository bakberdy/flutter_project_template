import 'package:shared/shared.dart';

abstract final class AdminProfileConstants {
  static const int phoneNumberDigitsRequired = 10;

  static const List<CountryDialCode> countryDialCodes = [
    CountryDialCode(countryCode: 'KZ', dialCode: '+7'),
    CountryDialCode(countryCode: 'RU', dialCode: '+7'),
    CountryDialCode(countryCode: 'US', dialCode: '+1'),
    CountryDialCode(countryCode: 'GB', dialCode: '+44'),
  ];
}
