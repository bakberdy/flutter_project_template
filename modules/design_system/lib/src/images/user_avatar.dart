import 'package:design_system/src/images/base_cached_network_image.dart';
import 'package:design_system/src/tokens/design_spacing.dart';
import 'package:flutter/material.dart';

enum UserAvatarFormat { circle, square }

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.fullName,
    this.avatarUrl,
    this.baseUrl,
    this.radius = 50,
    this.format = UserAvatarFormat.circle,
    this.backgroundColor,
    this.onTap,
    this.loading = false,
    this.loadingProgress,
  });

  final String? fullName;
  final String? avatarUrl;
  final String? baseUrl;
  final double radius;
  final UserAvatarFormat format;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool loading;
  final double? loadingProgress;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(fullName);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox.square(
        dimension: radius * 2,
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: format == UserAvatarFormat.circle
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  color:
                      backgroundColor ??
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: _hasAvatar
                    ? BaseCachedNetworkImage(
                        imageUrl: avatarUrl!,
                        baseUrl: baseUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            _AvatarInitials(initials: initials),
                      )
                    : _AvatarInitials(initials: initials),
              ),
              if (loading)
                Center(
                  child: CircularProgressIndicator(value: loadingProgress),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _hasAvatar => avatarUrl?.trim().isNotEmpty ?? false;

  BorderRadius get _borderRadius => BorderRadius.circular(
    format == UserAvatarFormat.circle ? radius : DesignSpacing.sm,
  );

  String _initials(String? value) {
    final parts = value
        ?.trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts == null || parts.isEmpty) {
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

class _AvatarInitials extends StatelessWidget {
  const _AvatarInitials({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
