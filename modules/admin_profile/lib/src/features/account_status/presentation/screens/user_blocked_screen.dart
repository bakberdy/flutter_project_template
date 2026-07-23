import 'package:admin_profile/src/common/presentation/extensions/admin_profile_context_x.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core_navigation/core_navigation_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserBlockedScreen extends StatelessWidget {
  const UserBlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignSpacingTokens.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.block, size: 56, color: context.designColors.error),
              const SizedBox(height: DesignSpacingTokens.lg),
              Text(
                context.l10n.userBlockedTitle,
                textAlign: TextAlign.center,
                style: context.designTextTheme.headlineSmall,
              ),
              const SizedBox(height: DesignSpacingTokens.sm),
              Text(
                context.l10n.userBlockedMessage,
                textAlign: TextAlign.center,
                style: context.designTextTheme.bodyMedium,
              ),
              const SizedBox(height: DesignSpacingTokens.xl),
              BaseButton.primary(
                onPressed: () {
                  context.router.markUrlStateForReplace();
                  context.read<CoreNavigationBloc>().add(
                    const CoreNavigationEvent.loggedOut(),
                  );
                },
                label: context.l10n.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
