import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:client_auth/src/features/users/domain/entities/user_avatar_upload.dart';
import 'package:client_auth/src/features/users/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:client_auth/src/features/users/presentation/widgets/app_support_items_list.dart';
import 'package:client_auth/src/features/users/presentation/widgets/app_version_view.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_avatar.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_preferences_items_list.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_profile_app_bar.dart';
import 'package:client_auth/src/router/client_auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget
    with UiFailureHandlerMixin
    implements AutoRouteWrapper {
  const UserProfileScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listenWhen: (previous, current) =>
          previous.avatarStatus != current.avatarStatus,
      listener: _onAvatarStatusChanged,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                final profile = state.profile;
                final avatarUrl = profile?.avatarUrl;
                return UserProfileAppBar(
                  fullName: state.profile?.fullName,
                  email: state.user?.email,
                  avatarUrl: state.profile?.avatarUrl,
                  avatarLoading: state.avatarStatus.isLoading,
                  avatarLoadingProgress: state.avatarUploadProgress,
                  onShare: () {},
                  onEdit: () async {
                    await context.router.push(const UserProfileEditRoute());
                  },
                  onViewAvatar: avatarUrl == null || avatarUrl.trim().isEmpty
                      ? null
                      : () =>
                            _showAvatar(context, profile?.fullName, avatarUrl),
                  onChangeAvatar: () => _pickAvatar(context),
                  onRemoveAvatar: profile?.avatarUrl == null
                      ? null
                      : () => _confirmRemoveAvatar(context),
                  phoneNumber: profile?.phoneNumber?.displayValue,
                );
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: DesignSpacing.xl)),
            UserPreferencesItemsList(
              onNotificationsTap: () async {
                await context.router.push(
                  const UserPreferencesNotificationsRoute(),
                );
              },
              onAppearanceTap: () async {
                await context.router.push(
                  const UserPreferencesAppearanceRoute(),
                );
              },
              onLanguageTap: () async {
                await context.router.push(const UserPreferencesLocaleRoute());
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: DesignSpacing.md)),
            SliverToBoxAdapter(
              child: AppItemCard(
                trailing: const Icon(Icons.chevron_right),
                leading: const Icon(Icons.devices),
                title: context.l10n.profilePreferencesDevices,
                onTap: () async {
                  await context.router.push(const SessionsRoute());
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: DesignSpacing.md)),
            AppSupportItemsList(onFAQTap: () {}, onSupportTap: () {}),
            Builder(
              builder: (context) {
                final appInfo = context.select<UserProfileBloc, AppInfo?>(
                  (bloc) => bloc.state.appInfo,
                );
                final showAppBuildDetails = context
                    .select<UserProfileBloc, bool>(
                      (bloc) => bloc.state.showAppBuildDetails,
                    );
                return AppVersionView(
                  version: appInfo?.version,
                  buildNumber: appInfo?.buildNumber,
                  appName: appInfo?.appName,
                  packageName: appInfo?.packageName,
                  showBuildDetails: showAppBuildDetails,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAvatarStatusChanged(
    BuildContext context,
    UserProfileState state,
  ) async {
    switch (state.avatarStatus) {
      case ErrorStateStatus(:final failure):
        await handleFailure(failure, context);
        break;
      case SuccessStateStatus():
        final message = state.avatarAction == UserProfileAvatarAction.remove
            ? context.l10n.profileAvatarRemovedSuccessMessage
            : context.l10n.profileAvatarUpdatedSuccessMessage;
        BaseSnackbar.success(context, message: message);
        break;
      default:
        return;
    }

    if (!context.mounted) {
      return;
    }
    context.read<UserProfileBloc>().add(
      const UserProfileEvent.avatarStatusReset(),
    );
  }

  Future<void> _pickAvatar(BuildContext context) async {
    final file = await AppFilePicker.pickFile(
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (file == null || !context.mounted) {
      return;
    }

    context.read<UserProfileBloc>().add(
      UserProfileEvent.avatarUploadRequested(
        UserAvatarUpload(
          bytes: file.bytes,
          filename: file.filename,
          sourcePath: file.sourcePath,
          contentType: file.contentType,
        ),
      ),
    );
  }

  Future<void> _confirmRemoveAvatar(BuildContext context) async {
    final shouldRemove = await BaseDialog.show<bool>(
      context,
      title: context.l10n.profileAvatarRemoveDialogTitle,
      description: context.l10n.profileAvatarRemoveDialogMessage,
      primaryLabel: context.l10n.profileAvatarActionRemove,
      secondaryLabel: context.l10n.dismiss,
      primaryValue: true,
      secondaryValue: false,
      primaryFirst: true,
    );
    if (shouldRemove != true || !context.mounted) {
      return;
    }
    context.read<UserProfileBloc>().add(
      const UserProfileEvent.avatarRemoveRequested(),
    );
  }

  Future<void> _showAvatar(
    BuildContext context,
    String? fullName,
    String avatarUrl,
  ) async {
    await BaseDialog.show<void>(
      context,
      body: UserAvatar(
        fullName: fullName,
        avatarUrl: avatarUrl,
        radius: 120,
        format: UserAvatarFormat.square,
      ),
    );
  }
}
