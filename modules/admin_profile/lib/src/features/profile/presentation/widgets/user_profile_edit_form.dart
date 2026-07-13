import 'package:design_system/design_system.dart';
import 'package:core/core.dart';
import 'package:admin_profile/src/common/admin_profile_context_x.dart';
import 'package:admin_profile/src/features/profile/presentation/helpers/user_profile_phone_number_validation.dart';
import 'package:admin_profile/src/features/profile/presentation/widgets/user_profile_full_name_text_field.dart';
import 'package:flutter/material.dart';

class UserProfileEditForm extends StatelessWidget {
  const UserProfileEditForm({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    required this.saveStatus,
    required this.hasUnsavedChanges,
    required this.canSaveChanges,
    this.accountDeletionStatus = const StateStatus.initial(),
    required this.dialCode,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.phoneFieldLayerLink,
    required this.onDismissOverlay,
    required this.onFullNameChanged,
    required this.onPhoneNumberChanged,
    required this.onCountryCodeTap,
    required this.onSavePressed,
    this.onLogoutPressed,
    this.onRemoveAccountPressed,
    this.onVerifyPhonePressed,
    required this.onPopDiscardRequested,
    this.showPhoneVerificationPrompt = false,
    this.showPhoneVerified = false,
    this.isInitialLoading = false,
    this.avatarUrl,
    this.showAppBar = true,
  });

  final FieldState<String> fullName;
  final FieldState<UserPhoneNumber> phoneNumber;
  final StateStatus saveStatus;
  final bool hasUnsavedChanges;
  final bool canSaveChanges;
  final StateStatus accountDeletionStatus;
  final bool showPhoneVerificationPrompt;
  final bool showPhoneVerified;
  final CountryDialCodeOption? dialCode;
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final LayerLink phoneFieldLayerLink;
  final VoidCallback onDismissOverlay;
  final ValueChanged<String> onFullNameChanged;
  final ValueChanged<String> onPhoneNumberChanged;
  final VoidCallback onCountryCodeTap;
  final VoidCallback onSavePressed;
  final VoidCallback? onLogoutPressed;
  final VoidCallback? onRemoveAccountPressed;
  final VoidCallback? onVerifyPhonePressed;
  final Future<bool?> Function() onPopDiscardRequested;
  final bool isInitialLoading;
  final String? avatarUrl;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (isInitialLoading && fullNameController.text.isEmpty) {
      return showAppBar
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : const Center(child: CircularProgressIndicator());
    }

    return PopScope(
      canPop: !hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || !hasUnsavedChanges) {
          return;
        }

        final shouldPop = await onPopDiscardRequested();
        if (shouldPop ?? false) {
          if (!context.mounted) {
            return;
          }
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: showAppBar ? AppBar(title: Text(l10n.profileEditTitle)) : null,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            onDismissOverlay();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: DesignSpacing.xl,
                    bottom: DesignSpacing.lg,
                  ),
                  child: Center(
                    child: UserAvatar(
                      fullName: fullName.value,
                      avatarUrl: avatarUrl,
                      baseUrl: context.di<CoreAppConfig>().baseUrl,
                      radius: 44,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSpacing.md,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      l10n.profileEditFullNameLabel,
                      style: context.designTextTheme.labelLarge,
                    ),
                    const SizedBox(height: DesignSpacing.xs),
                    UserProfileFullNameTextField(
                      controller: fullNameController,
                      errorText: fullName.error,
                      onChanged: onFullNameChanged,
                    ),
                    const SizedBox(height: DesignSpacing.md),
                    Text(
                      l10n.profileEditPhoneNumberLabel,
                      style: context.designTextTheme.labelLarge,
                    ),
                    const SizedBox(height: DesignSpacing.xs),
                    BasePhoneNumberTextField(
                      labelText: l10n.profileEditPhoneNumberLabel,
                      showVerificationPrompt: showPhoneVerificationPrompt,
                      showVerified: showPhoneVerified,
                      verifiedLabel: l10n.profileEditPhoneVerified,
                      verificationPromptLabel:
                          l10n.profileEditPhoneVerificationPrompt,
                      verifyActionLabel: l10n.profileEditVerifyNow,
                      errorText: mapPhoneNumberErrorText(
                        context,
                        phoneNumber.error,
                      ),
                      onVerifyTap: onVerifyPhonePressed,
                      controller: phoneNumberController,
                      onChanged: onPhoneNumberChanged,
                      layerLink: phoneFieldLayerLink,
                      dialCode: dialCode,
                      onCountryCodeTap: onCountryCodeTap,
                    ),
                    if (onLogoutPressed != null ||
                        onRemoveAccountPressed != null) ...[
                      const SizedBox(height: DesignSpacing.xl),
                      if (onLogoutPressed != null)
                        BaseButton.secondary(
                          onPressed: onLogoutPressed,
                          label: l10n.profileEditLogout,
                          leadingIcon: const Icon(Icons.logout),
                        ),
                      if (onLogoutPressed != null &&
                          onRemoveAccountPressed != null)
                        const SizedBox(height: DesignSpacing.sm),
                      if (onRemoveAccountPressed != null)
                        BaseButton.destructive(
                          onPressed: onRemoveAccountPressed,
                          label: l10n.profileEditRemoveAccount,
                          leadingIcon: const Icon(Icons.delete_outline),
                          loading: accountDeletionStatus.isLoading,
                        ),
                    ],
                    const SizedBox(height: 96),
                  ]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
          child: BaseButton.primary(
            onPressed: onSavePressed,
            disabled: !canSaveChanges,
            loading: saveStatus.isLoading,
            label: l10n.profileEditSaveChanges,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
