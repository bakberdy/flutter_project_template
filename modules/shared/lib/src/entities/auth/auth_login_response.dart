import 'package:equatable/equatable.dart';

class AuthLoginResponse extends Equatable {
  const AuthLoginResponse({
    required this.message,
    required this.loginRequestId,
    required this.otpExpiresIn,
  });

  final String message;
  final String loginRequestId;
  final int otpExpiresIn;

  @override
  List<Object?> get props => [message, loginRequestId, otpExpiresIn];
}
