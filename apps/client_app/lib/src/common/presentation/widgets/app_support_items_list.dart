import 'package:design_system/design_system.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:flutter/material.dart';

class AppSupportItemsList extends StatelessWidget {
  const AppSupportItemsList({
    super.key,
    required this.onFAQTap,
    required this.onSupportTap,
  });
  final VoidCallback onFAQTap;
  final VoidCallback onSupportTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        BaseListTile(
          onTap: onFAQTap,
          title: context.l10n.profileSupportFaq,
          leading: const Icon(Icons.help_outline),
          trailing: const Icon(Icons.chevron_right),
          disableBottomRadius: true,
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        BaseListTile(
          disableTopRadius: true,
          onTap: onSupportTap,
          title: context.l10n.profileSupportSupport,
          leading: const Icon(Icons.support_agent_outlined),
          trailing: const Icon(Icons.chevron_right),
        ),
      ]),
    );
  }
}
