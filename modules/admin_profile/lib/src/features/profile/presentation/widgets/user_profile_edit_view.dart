import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:admin_profile/src/common/admin_profile_context_x.dart';
import 'package:admin_profile/src/common/config/admin_profile_constants.dart';
import 'package:admin_profile/src/features/profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:admin_profile/src/features/profile/presentation/blocs/user_profile_edit/user_profile_edit_bloc.dart';
import 'package:admin_profile/src/features/profile/presentation/widgets/user_profile_edit_form.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileEditView extends StatelessWidget {
  const UserProfileEditView({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            context.di<UserProfileBloc>()
              ..add(const UserProfileEvent.started()),
      ),
      BlocProvider(create: (context) => context.di<UserProfileEditBloc>()),
    ],
    child: const _UserProfileEditContent(),
  );
}

class _UserProfileEditContent extends StatefulWidget {
  const _UserProfileEditContent();

  @override
  State<_UserProfileEditContent> createState() =>
      _UserProfileEditContentState();
}

class _UserProfileEditContentState extends State<_UserProfileEditContent>
    with UiFailureHandlerMixin {
  final phoneFieldLayerLink = LayerLink();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryCodeSelector = BaseCountryDialCodeSelectorOverlay();
  bool _profileInitialized = false;

  void _onCountryCodeSelected(CountryDialCodeOption value) {
    context.read<UserProfileEditBloc>().add(
      UserProfileEditEvent.countryCodeSelected(_countryDialCodeFrom(value)),
    );
  }

  @override
  void dispose() {
    countryCodeSelector.close();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<UserProfileBloc>().state;
    final editState = context.watch<UserProfileEditBloc>().state;

    final profileToInitialize = _profileToInitialize(profileState);
    if (profileToInitialize != null) {
      _scheduleProfileInitialization(profileToInitialize);
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileBloc, UserProfileState>(
          listenWhen: (previous, current) =>
              previous.profileStatus != current.profileStatus ||
              previous.accountDeletionStatus != current.accountDeletionStatus,
          listener: _onProfileStateChanged,
        ),
        BlocListener<UserProfileEditBloc, UserProfileEditState>(
          listenWhen: (previous, current) =>
              previous.saveStatus != current.saveStatus,
          listener: _onEditStateChanged,
        ),
      ],
      child: UserProfileEditForm(
        fullName: editState.fullName,
        phoneNumber: editState.phoneNumber,
        saveStatus: editState.saveStatus,
        hasUnsavedChanges: editState.hasUnsavedChanges,
        canSaveChanges: editState.canSaveChanges,
        accountDeletionStatus: profileState.accountDeletionStatus,
        avatarUrl: profileState.profile?.avatarUrl,
        showPhoneVerificationPrompt:
            false, //editState.showPhoneVerificationPrompt,
        showPhoneVerified: false, //editState.showPhoneVerified,
        dialCode: _dialCodeFromPhoneNumber(editState.phoneNumber.value),
        isInitialLoading:
            profileState.profileStatus.isLoading &&
            fullNameController.text.isEmpty,
        fullNameController: fullNameController,
        phoneNumberController: phoneNumberController,
        phoneFieldLayerLink: phoneFieldLayerLink,
        onDismissOverlay: countryCodeSelector.hide,
        onFullNameChanged: _onFullNameChanged,
        onPhoneNumberChanged: _onPhoneNumberChanged,
        onCountryCodeTap: _showCountryCodeOverlay,
        onSavePressed: _onSavePressed,
        onRemoveAccountPressed: _onRemoveAccountPressed,
        onVerifyPhonePressed: () => _onVerifyPhonePressed(editState),
        onPopDiscardRequested: _showDiscardChangesDialog,
      ),
    );
  }

  Future<void> _onProfileStateChanged(
    BuildContext context,
    UserProfileState state,
  ) async {
    if (state.profileStatus case ErrorStateStatus(:final failure)) {
      await handleFailure(failure, context);
      if (!context.mounted) {
        return;
      }
    }
    switch (state.accountDeletionStatus) {
      case ErrorStateStatus(:final failure):
        await handleFailure(failure, context);
        if (!context.mounted) {
          return;
        }
        context.read<UserProfileBloc>().add(
          const UserProfileEvent.accountDeletionStatusReset(),
        );
        break;
      case SuccessStateStatus():
        context.read<UserProfileBloc>().add(
          const UserProfileEvent.accountDeletionStatusReset(),
        );
        Navigator.of(context).pop();
        context.read<CoreNavigationBloc>().add(
          const CoreNavigationEvent.refreshUser(),
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onEditStateChanged(
    BuildContext context,
    UserProfileEditState state,
  ) async {
    final failure = switch (state.saveStatus) {
      ErrorStateStatus(:final failure) => failure,
      _ => null,
    };
    if (failure != null && _hasInlineFieldErrors(failure)) {
      return;
    }
    switch (state.saveStatus) {
      case ErrorStateStatus(:final failure):
        await handleFailure(failure, context);
        break;
      case SuccessStateStatus():
        _handleSaveSuccess(context);
        break;
      default:
        break;
    }
  }

  bool _hasInlineFieldErrors(Failure failure) {
    final fieldErrors = failure.details?.fieldErrors;
    return failure.details?.type == FailureType.inline &&
        fieldErrors != null &&
        fieldErrors.isNotEmpty;
  }

  void _handleSaveSuccess(BuildContext context) {
    BaseSnackbar.success(
      context,
      message: context.l10n.profileSavedSuccessMessage,
    );
    context.read<UserProfileEditBloc>().add(
      const UserProfileEditEvent.resetAfterSave(),
    );
    context.read<UserProfileBloc>().add(const UserProfileEvent.started());
  }

  void _onFullNameChanged(String value) {
    context.read<UserProfileEditBloc>().add(
      UserProfileEditEvent.fullNameChanged(value),
    );
  }

  void _onPhoneNumberChanged(String value) {
    context.read<UserProfileEditBloc>().add(
      UserProfileEditEvent.phoneNumberChanged(value: value),
    );
  }

  void _onSavePressed() {
    context.read<UserProfileEditBloc>().add(
      const UserProfileEditEvent.saveChangesRequested(),
    );
  }

  Future<void> _onRemoveAccountPressed() async {
    final accepted = await BaseDialog.show<bool>(
      context,
      title: context.l10n.profileEditRemoveAccountDialogTitle,
      description: context.l10n.profileEditRemoveAccountDialogMessage,
      primaryLabel: context.l10n.profileEditRemoveAccount,
      secondaryLabel: context.l10n.dismiss,
      primaryValue: true,
      secondaryValue: false,
      primaryFirst: true,
    );
    if (accepted == true && mounted) {
      context.read<UserProfileBloc>().add(
        const UserProfileEvent.accountDeletionRequested(),
      );
    }
  }

  Future<bool?> _showDiscardChangesDialog() {
    return BaseDialog.show<bool>(
      context,
      title: context.l10n.profileEditDiscardChangesTitle,
      description: context.l10n.profileEditDiscardChangesMessage,
      primaryLabel: context.l10n.profileEditDiscardChanges,
      secondaryLabel: context.l10n.dismiss,
      primaryValue: true,
      secondaryValue: false,
      primaryFirst: true,
    );
  }

  void _showCountryCodeOverlay() {
    if (countryCodeSelector.isVisible) {
      countryCodeSelector.hide();
      return;
    }

    countryCodeSelector.show(
      context: context,
      layerLink: phoneFieldLayerLink,
      dialCodes: _countryDialCodeOptions,
      onSelected: _onCountryCodeSelected,
    );
  }

  Future<void> _onVerifyPhonePressed(UserProfileEditState editState) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final phoneNumber = editState.phoneNumber.value;
    final accepted = await _showVerifyPhoneBottomSheet(phoneNumber);
    if (accepted != true || !mounted) {
      return;
    }

    final bloc = context.read<UserProfileEditBloc>()
      ..add(const UserProfileEditEvent.otpSheetOpened());
    await _showOtpBottomSheet(bloc, phoneNumber);
  }

  Future<bool?> _showVerifyPhoneBottomSheet(UserPhoneNumber phoneNumber) {
    return BaseBottomSheet.show<bool?>(
      isScrollControlled: false,
      routeName: 'phone_verification_request',
      title: context.l10n.profileEditPhoneVerificationRequestTitle,
      context: context,
      actions: [
        BaseButton.secondary(
          onPressed: () => Navigator.pop<bool>(context, false),
          label: context.l10n.dismiss,
        ),
        BaseButton.primary(
          onPressed: () => Navigator.pop<bool>(context, true),
          label: context.l10n.profileEditPhoneVerificationSendCode,
          trailingIcon: const Icon(Icons.chevron_right),
        ),
      ],
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          context.l10n.profileEditPhoneVerificationRequestMessage(
            phoneNumber.displayValue,
          ),
        ),
      ),
    );
  }

  Future<void> _showOtpBottomSheet(
    UserProfileEditBloc bloc,
    UserPhoneNumber phoneNumber,
  ) {
    return BaseBottomSheet.show(
      context: context,
      title: context.l10n.profileEditOtpBottomSheetTitle,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
          builder: (context, state) => BaseOtpVerificationBottomSheet(
            errorText: state.otpInvalid
                ? context.l10n.profileEditInvalidOtpMessage
                : null,
            loading: state.otpStatus.isLoading,
            buttonLabel: context.l10n.profileEditVerifyNow,
            otpLength: state.otpLength,
            onOtpSubmitted: (otpCode) {
              context.read<UserProfileEditBloc>().add(
                UserProfileEditEvent.otpSubmitted(otpCode),
              );
            },
            description: context.l10n.profileEditOtpBottomSheetDescription(
              phoneNumber.displayValue,
            ),
          ),
        ),
      ),
    );
  }

  UserProfile? _profileToInitialize(UserProfileState state) {
    if (_profileInitialized || !state.profileStatus.isSuccess) {
      return null;
    }
    return state.profile;
  }

  void _scheduleProfileInitialization(UserProfile profile) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _profileInitialized) {
        return;
      }
      _initializeProfileForm(profile);
    });
  }

  void _initializeProfileForm(UserProfile profile) {
    _profileInitialized = true;
    fullNameController.text = profile.fullName;
    phoneNumberController.text = BasePhoneNumberInputFormatter.formatForDisplay(
      profile.phoneNumber?.number ?? '',
    );
    context.read<UserProfileEditBloc>().add(
      UserProfileEditEvent.started(profile),
    );
  }

  CountryDialCodeOption? _dialCodeFromPhoneNumber(UserPhoneNumber phoneNumber) {
    return _countryDialCodeOptions.firstWhere(
      (code) =>
          code.countryCode == phoneNumber.countryCode ||
          code.dialCode == phoneNumber.dialCode,
      orElse: () => _countryDialCodeOptions.last,
    );
  }

  CountryDialCode _countryDialCodeFrom(CountryDialCodeOption value) {
    return AdminProfileConstants.countryDialCodes.firstWhere(
      (code) =>
          code.countryCode == value.countryCode ||
          code.dialCode == value.dialCode,
    );
  }

  List<CountryDialCodeOption> get _countryDialCodeOptions =>
      AdminProfileConstants.countryDialCodes
          .map(
            (code) => CountryDialCodeOption(
              countryCode: code.countryCode,
              dialCode: code.dialCode,
            ),
          )
          .toList(growable: false);
}
