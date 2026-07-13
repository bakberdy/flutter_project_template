import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_auth/src/features/users/configs/user_profile_dial_codes.dart';
import 'package:client_auth/src/features/users/presentation/blocs/create_user_profile_bloc/create_user_profile_bloc.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_profile_edit_form.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserDataRegistrationScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const UserDataRegistrationScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.di<CreateUserProfileBloc>()
            ..add(const CreateUserProfileEvent.started()),
      child: this,
    );
  }

  @override
  State<UserDataRegistrationScreen> createState() =>
      _UserDataRegistrationScreenState();
}

class _UserDataRegistrationScreenState extends State<UserDataRegistrationScreen>
    with UiFailureHandlerMixin {
  final phoneFieldLayerLink = LayerLink();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryCodeSelector = BaseCountryDialCodeSelectorOverlay();

  void _onCountryCodeSelected(CountryDialCodeOption value) {
    context.read<CreateUserProfileBloc>().add(
      CreateUserProfileEvent.countryCodeSelected(_countryDialCodeFrom(value)),
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
    final l10n = ClientAuthLocalizations.of(context);
    final bloc = context.watch<CreateUserProfileBloc>();
    final state = bloc.state;
    return BlocListener<CreateUserProfileBloc, CreateUserProfileState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus,
      listener: (context, state) async {
        final failure = switch (state.saveStatus) {
          ErrorStateStatus(:final failure) => failure,
          _ => null,
        };
        if (failure != null &&
            failure.details?.type == FailureType.inline &&
            failure.details?.fieldErrors != null &&
            failure.details!.fieldErrors!.isNotEmpty) {
          return;
        }
        switch (state.saveStatus) {
          case ErrorStateStatus(:final failure):
            await handleFailure(failure, context);
            break;
          case SuccessStateStatus():
            BaseSnackbar.success(
              context,
              message: l10n.profileSavedSuccessMessage,
            );
            context.read<CoreNavigationBloc>().add(
              const CoreNavigationEvent.refreshUser(),
            );
            break;
          default:
            break;
        }
      },
      child: UserProfileEditForm(
        fullName: state.fullName,
        phoneNumber: state.phoneNumber,
        saveStatus: state.saveStatus,
        hasUnsavedChanges: state.hasUnsavedChanges,
        canSaveChanges: state.canSaveChanges,
        dialCode: _dialCodeFromPhoneNumber(state.phoneNumber.value),
        fullNameController: fullNameController,
        phoneNumberController: phoneNumberController,
        phoneFieldLayerLink: phoneFieldLayerLink,
        onDismissOverlay: countryCodeSelector.hide,
        onFullNameChanged: (value) {
          bloc.add(CreateUserProfileEvent.fullNameChanged(value));
        },
        onPhoneNumberChanged: (value) {
          bloc.add(CreateUserProfileEvent.phoneNumberChanged(value: value));
        },
        onCountryCodeTap: () {
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
        },
        onSavePressed: () {
          bloc.add(const CreateUserProfileEvent.saveRequested());
        },
        onPopDiscardRequested: () => showDiscardChangesDialog(context),
      ),
    );
  }

  Future<bool?> showDiscardChangesDialog(BuildContext context) {
    return BaseDialog.show<bool>(
      context,
      title: ClientAuthLocalizations.of(context).profileEditDiscardChangesTitle,
      description: ClientAuthLocalizations.of(
        context,
      ).profileEditDiscardChangesMessage,
      primaryLabel: ClientAuthLocalizations.of(
        context,
      ).profileEditDiscardChanges,
      secondaryLabel: ClientAuthLocalizations.of(context).dismiss,
      primaryValue: true,
      secondaryValue: false,
      primaryFirst: true,
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
    return countryDialCodes.firstWhere(
      (code) =>
          code.countryCode == value.countryCode ||
          code.dialCode == value.dialCode,
    );
  }

  List<CountryDialCodeOption> get _countryDialCodeOptions => countryDialCodes
      .map(
        (code) => CountryDialCodeOption(
          countryCode: code.countryCode,
          dialCode: code.dialCode,
        ),
      )
      .toList(growable: false);
}
