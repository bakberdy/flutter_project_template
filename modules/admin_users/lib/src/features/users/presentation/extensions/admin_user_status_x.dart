import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:flutter/material.dart';

extension AdminUserStatusX on AdminUserStatus {
  Color get color {
    switch (this) {
      case AdminUserStatus.active:
        return const Color(0xFF22C55E); // Green 500

      case AdminUserStatus.blocked:
        return const Color(0xFFF59E0B); // Amber 500

      case AdminUserStatus.deleted:
        return const Color(0xFFEF4444); // Red 500

      case AdminUserStatus.deletionRequested:
        return const Color(0xFF3B82F6); // Blue 500
    }
  }
}
