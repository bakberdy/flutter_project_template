import 'package:equatable/equatable.dart';

class VerifyRequest extends Equatable {
  final String loginRequestId;
  final String email;
  final String code;

  const VerifyRequest({
    required this.loginRequestId,
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => [loginRequestId, email, code];
}
