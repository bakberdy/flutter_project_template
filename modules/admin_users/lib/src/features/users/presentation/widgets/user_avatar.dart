import 'package:flutter/material.dart';

enum UserAvatarFormat { circle, square }

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.fullName,
    this.avatarUrl,
    this.radius = 24,
    this.format = UserAvatarFormat.circle,
  });

  final String fullName;
  final String? avatarUrl;
  final double radius;
  final UserAvatarFormat format;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(fullName);
    final imageProvider = avatarUrl == null || avatarUrl!.isEmpty
        ? null
        : NetworkImage(avatarUrl!);
    final borderRadius = switch (format) {
      UserAvatarFormat.circle => BorderRadius.circular(radius),
      UserAvatarFormat.square => BorderRadius.circular(12),
    };

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: imageProvider == null
            ? Center(
                child: Text(
                  initials,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Image(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.characters.take(2).toString().toUpperCase();
    }
    return parts
        .take(2)
        .map((part) => part.characters.first)
        .join()
        .toUpperCase();
  }
}
