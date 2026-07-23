import 'package:equatable/equatable.dart';

class AuthVerifyRequest extends Equatable {
  const AuthVerifyRequest({
    required this.loginRequestId,
    required this.email,
    required this.code,
  });

  final String loginRequestId;
  final String email;
  final String code;

  @override
  List<Object?> get props => [loginRequestId, email, code];
}
