import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserAvatarInitials extends StatelessWidget {
  const UserAvatarInitials({required this.initials, super.key});

  final String initials;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      initials,
      style: context.designTextTheme.headlineLarge?.copyWith(
        color: context.designColors.onPrimaryContainer,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
