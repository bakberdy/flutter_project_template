import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String message;
  final String loginRequestId;
  final int otpExpiresIn;

  const LoginResponse({
    required this.message,
    required this.loginRequestId,
    required this.otpExpiresIn,
  });

  @override
  List<Object?> get props => [message, loginRequestId, otpExpiresIn];
}
