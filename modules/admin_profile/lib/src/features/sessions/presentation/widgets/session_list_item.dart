import 'package:design_system/design_system.dart';
import 'package:admin_profile/src/common/admin_profile_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SessionListItem extends StatelessWidget {
  const SessionListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onRevoke,
    required this.disableTopRadius,
    required this.disableBottomRadius,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onRevoke;
  final bool disableTopRadius;
  final bool disableBottomRadius;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius: BorderRadius.vertical(
              top: disableTopRadius
                  ? Radius.zero
                  : const Radius.circular(DesignRadii.lg),
              bottom: disableBottomRadius
                  ? Radius.zero
                  : const Radius.circular(DesignRadii.lg),
            ),
            onPressed: onRevoke == null ? null : (_) => onRevoke!(),
            backgroundColor: context.designColors.error,
            foregroundColor: context.designColors.onError,
            icon: Icons.cancel_outlined,
            label: context.l10n.revokeSession,
          ),
        ],
      ),
      child: BaseListTile(
        margin: EdgeInsets.zero,
        disableTopRadius: disableTopRadius,
        disableBottomRadius: disableBottomRadius,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
