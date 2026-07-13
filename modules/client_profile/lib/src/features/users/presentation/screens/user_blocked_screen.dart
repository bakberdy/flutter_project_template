import 'package:auto_route/auto_route.dart';
import 'package:core/core_navigation/core_navigation_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:client_profile/src/common/client_profile_context_x.dart';
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
          padding: const EdgeInsets.all(DesignSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.block, size: 56, color: context.colorScheme.error),
              const SizedBox(height: DesignSpacing.lg),
              Text(
                context.l10n.userBlockedTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: DesignSpacing.sm),
              Text(
                context.l10n.userBlockedMessage,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: DesignSpacing.xl),
              BaseButton.primary(
                onPressed: () => context.read<CoreNavigationBloc>().add(
                  const CoreNavigationEvent.unAuthenticated(),
                ),
                label: context.l10n.continueToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
