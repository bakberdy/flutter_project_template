import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserAvatarInitials extends StatelessWidget {
  const UserAvatarInitials({super.key, required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: context.textTheme.headlineLarge?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
