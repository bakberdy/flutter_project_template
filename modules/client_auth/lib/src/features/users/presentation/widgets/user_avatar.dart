import 'package:design_system/design_system.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_avatar_initials.dart';
import 'package:client_auth/src/common/widgets/app_cached_network_image.dart';
import 'package:flutter/material.dart';

enum UserAvatarFormat { circle, square }

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.fullName,
    this.avatarUrl,
    this.radius = 50,
    this.format = UserAvatarFormat.circle,
    this.backgroundColor,
    this.onTap,
    this.loading = false,
    this.loadingProgress,
  });
  final String? fullName;
  final String? avatarUrl;
  final double radius;
  final UserAvatarFormat format;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool loading;
  final double? loadingProgress;

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(fullName);

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
                      backgroundColor ?? context.colorScheme.primaryContainer,
                ),
                child: avatarUrl == null || avatarUrl!.trim().isEmpty
                    ? UserAvatarInitials(initials: initials)
                    : AppCachedNetworkImage(
                        imageUrl: avatarUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox.square(
                          dimension: radius,
                          child: const CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            UserAvatarInitials(initials: initials),
                      ),
              ),
              if (loading) ...[
                SizedBox.square(
                  dimension: radius,
                  child: CircularProgressIndicator(value: loadingProgress),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius get _borderRadius {
    return BorderRadius.circular(
      format == UserAvatarFormat.circle ? radius : DesignSpacing.sm,
    );
  }

  String _getInitials(String? name) {
    try {
      final parts = name?.split(' ') ?? [];
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      } else if (parts.isNotEmpty) {
        return parts[0][0].toUpperCase();
      }
      return 'AA';
    } catch (e) {
      return 'AA';
    }
  }
}
