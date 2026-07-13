import 'package:design_system/design_system.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
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
    final textStyle = context.textTheme.bodyMedium;
    final version = this.version;
    final buildNumber = this.buildNumber;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          const Spacer(),
          const SizedBox(height: DesignSpacing.lg),
          if (version != null && buildNumber != null)
            SelectableText(
              ClientAuthLocalizations.of(
                context,
              ).appVersionWithBuild(version, buildNumber),
              style: textStyle,
            ),
          if (showBuildDetails) ...[
            const SizedBox(height: DesignSpacing.sm),
            if (appName != null)
              SelectableText(
                ClientAuthLocalizations.of(context).appNameValue(appName!),
                style: textStyle,
              ),
            if (packageName != null)
              SelectableText(
                ClientAuthLocalizations.of(
                  context,
                ).appPackageNameValue(packageName!),
                style: textStyle,
              ),
            if (buildNumber != null)
              SelectableText(
                ClientAuthLocalizations.of(
                  context,
                ).appBuildNumberValue(buildNumber),
                style: textStyle,
              ),
          ],
          const SizedBox(height: DesignSpacing.xl),
        ],
      ),
    );
  }
}
