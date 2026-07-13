import 'package:design_system/design_system.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
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
        AppItemCard(
          onTap: onFAQTap,
          title: ClientAuthLocalizations.of(context).profileSupportFaq,
          leading: const Icon(Icons.help_outline),
          trailing: const Icon(Icons.chevron_right),
          disableBottomRadius: true,
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        AppItemCard(
          disableTopRadius: true,
          onTap: onSupportTap,
          title: ClientAuthLocalizations.of(context).profileSupportSupport,
          leading: const Icon(Icons.support_agent_outlined),
          trailing: const Icon(Icons.chevron_right),
        ),
      ]),
    );
  }
}
