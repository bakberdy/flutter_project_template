import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.settings)),
    body: Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(DesignSpacing.xl),
          child: DesignCard(
            child: Padding(
              padding: const EdgeInsets.all(DesignSpacing.lg),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: DesignSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.language,
                          style: context.designTextTheme.titleMedium,
                        ),
                        const SizedBox(height: DesignSpacing.xs),
                        Text(
                          context.l10n.languageDescription,
                          style: context.designTextTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
