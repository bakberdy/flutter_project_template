import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:client_app/src/common/presentation/widgets/app_support_items_list.dart';
import 'package:client_app/src/common/presentation/widgets/app_version_view.dart';
import 'package:client_app/src/common/presentation/widgets/user_preferences_items_list.dart';
import 'package:client_profile/client_profile.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget with UiFailureHandlerMixin {
  const UserProfileScreen({super.key});

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
                  onEdit: () => context.read<CoreNavigationBloc>().add(
                    const CoreNavigationEvent.push(UserProfileEditRoute()),
                  ),
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
              onNotificationsTap: () => context.read<CoreNavigationBloc>().add(
                const CoreNavigationEvent.push(
                  UserPreferencesNotificationsRoute(),
                ),
              ),
              onAppearanceTap: () => context.read<CoreNavigationBloc>().add(
                const CoreNavigationEvent.push(
                  UserPreferencesAppearanceRoute(),
                ),
              ),
              onLanguageTap: () => context.read<CoreNavigationBloc>().add(
                const CoreNavigationEvent.push(UserPreferencesLocaleRoute()),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: DesignSpacing.md)),
            SliverToBoxAdapter(
              child: BaseListTile(
                trailing: const Icon(Icons.chevron_right),
                leading: const Icon(Icons.devices),
                title: context.l10n.profilePreferencesDevices,
                onTap: () => context.read<CoreNavigationBloc>().add(
                  const CoreNavigationEvent.push(SessionsRoute()),
                ),
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
        baseUrl: context.di<CoreAppConfig>().baseUrl,
        radius: 120,
        format: UserAvatarFormat.square,
      ),
    );
  }
}
