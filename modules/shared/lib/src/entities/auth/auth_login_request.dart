import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/device/user_device.dart';

class AuthLoginRequest extends Equatable {
  const AuthLoginRequest({required this.email, required this.device});

  final String email;
  final UserDevice device;

  @override
  List<Object?> get props => [email, device];
}
