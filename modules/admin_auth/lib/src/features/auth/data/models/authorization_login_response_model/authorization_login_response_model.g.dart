// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      message: json['message'] as String,
      loginRequestId: json['login_request_id'] as String,
      otpExpiresIn: (json['otp_expires_in'] as num).toInt(),
    );
