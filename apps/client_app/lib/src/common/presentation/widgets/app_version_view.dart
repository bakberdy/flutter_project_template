import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppVersionView extends StatelessWidget {
  const AppVersionView({
    super.key,
    this.version,
    this.buildNumber,
    this.appName,
    this.packageName,
    this.showBuildDetails = false,
  });

  final String? version;
  final String? buildNumber;
  final String? appName;
  final String? packageName;
  final bool showBuildDetails;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.designTextTheme.bodyMedium;
    final version = this.version;
    final buildNumber = this.buildNumber;
    final appName = this.appName;
    final packageName = this.packageName;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          const Spacer(),
          const SizedBox(height: DesignSpacingTokens.lg),
          if (version != null && buildNumber != null)
            SelectableText(
              context.l10n.appVersionWithBuild(version, buildNumber),
              style: textStyle,
            ),
          if (showBuildDetails) ...[
            const SizedBox(height: DesignSpacingTokens.sm),
            if (appName != null)
              SelectableText(
                context.l10n.appNameValue(appName),
                style: textStyle,
              ),
            if (packageName != null)
              SelectableText(
                context.l10n.appPackageNameValue(packageName),
                style: textStyle,
              ),
            if (buildNumber != null)
              SelectableText(
                context.l10n.appBuildNumberValue(buildNumber),
                style: textStyle,
              ),
          ],
          const SizedBox(height: DesignSpacingTokens.xl),
        ],
      ),
    );
  }
}
