import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/auth/auth_device_info.dart';

class AuthLoginRequest extends Equatable {
  const AuthLoginRequest({required this.email, required this.device});

  final String email;
  final AuthDeviceInfo device;

  @override
  List<Object?> get props => [email, device];
}
