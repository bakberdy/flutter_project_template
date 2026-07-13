import 'package:auto_route/auto_route.dart';
import 'package:core/core_navigation/core_navigation_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:client_profile/src/common/client_profile_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserDeletionRequestedScreen extends StatelessWidget {
  const UserDeletionRequestedScreen({this.isDeleted = false, super.key});

  final bool isDeleted;

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
              Icon(
                Icons.delete_outline,
                size: 56,
                color: context.designColors.error,
              ),
              const SizedBox(height: DesignSpacing.lg),
              Text(
                isDeleted
                    ? context.l10n.userDeletedTitle
                    : context.l10n.userDeletionRequestedTitle,
                textAlign: TextAlign.center,
                style: context.designTextTheme.headlineSmall,
              ),
              const SizedBox(height: DesignSpacing.sm),
              Text(
                isDeleted
                    ? context.l10n.userDeletedMessage
                    : context.l10n.userDeletionRequestedMessage,
                textAlign: TextAlign.center,
                style: context.designTextTheme.bodyMedium,
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
