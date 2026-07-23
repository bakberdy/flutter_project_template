import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

extension AdminUserStatusX on UserStatus {
  Color get color {
    switch (this) {
      case UserStatus.active:
        return const Color(0xFF22C55E); // Green 500

      case UserStatus.blocked:
        return const Color(0xFFF59E0B); // Amber 500

      case UserStatus.deleted:
        return const Color(0xFFEF4444); // Red 500

      case UserStatus.deletionRequested:
        return const Color(0xFF3B82F6); // Blue 500
    }
  }
}
