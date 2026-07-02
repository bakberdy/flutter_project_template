import 'package:core/core.dart';

class AuthFailureDetails extends FailureDetails {
  const AuthFailureDetails({
    required super.statusCode,
    super.fieldErrors,
    super.type,
    this.attemptsLeft,
    this.blockedUntil,
  });

  final int? attemptsLeft;
  final String? blockedUntil;
}
