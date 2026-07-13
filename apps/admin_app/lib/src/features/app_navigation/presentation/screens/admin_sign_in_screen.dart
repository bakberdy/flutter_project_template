import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AdminSignInScreen extends StatefulWidget implements AutoRouteWrapper {
  const AdminSignInScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (context) => context.di<AuthBloc>(), child: this);

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
    with UiFailureHandlerMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _otpController.addListener(_onOtpChanged);
  }

  @override
  void dispose() {
    _emailController
      ..removeListener(_onEmailChanged)
      ..dispose();
    _otpController
      ..removeListener(_onOtpChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listenWhen: (previous, current) =>
        previous.status != current.status || previous.step != current.step,
    listener: _onStateChanged,
    builder: (context, state) {
      final l10n = context.l10n;
      final isEmailStep = state.step == AuthStep.email;
      final canSubmit = isEmailStep
          ? state.emailField.value?.trim().isNotEmpty ?? false
          : state.otpCodeField.value?.trim().length == 6;

      return Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 5,
              child: ColoredBox(
                color: context.designColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(64),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Text(
                        l10n.signInHero,
                        style: context.designTextTheme.displaySmall?.copyWith(
                          color: context.designColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(48),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.admin_panel_settings_outlined,
                          size: 52,
                          color: context.designColors.primary,
                        ),
                        const SizedBox(height: DesignSpacing.xl),
                        Text(
                          l10n.signInTitle,
                          style: context.designTextTheme.headlineLarge,
                        ),
                        const SizedBox(height: DesignSpacing.xs),
                        Text(
                          isEmailStep
                              ? l10n.signInEmailDescription
                              : l10n.signInOtpDescription(
                                  state.emailField.value ?? '',
                                ),
                          style: context.designTextTheme.bodyLarge,
                        ),
                        const SizedBox(height: DesignSpacing.xl),
                        if (isEmailStep)
                          TextField(
                            controller: _emailController,
                            autofocus: true,
                            enabled: !state.status.isLoading,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => canSubmit ? _submit() : null,
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              errorText: state.emailField.error,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          )
                        else
                          BaseOtpTextField(
                            controller: _otpController,
                            enabled: !state.status.isLoading,
                            errorText: state.otpCodeField.error,
                          ),
                        const SizedBox(height: DesignSpacing.lg),
                        BaseButton.primary(
                          label: isEmailStep ? l10n.continueLabel : l10n.signIn,
                          loading: state.status.isLoading,
                          disabled: !canSubmit,
                          onPressed: _submit,
                        ),
                        if (!isEmailStep) ...[
                          const SizedBox(height: DesignSpacing.sm),
                          BaseButton.secondary(
                            label: l10n.backToEmail,
                            disabled: state.status.isLoading,
                            onPressed: () => context.read<AuthBloc>().add(
                              const AuthEvent.backToEmail(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  void _onEmailChanged() => context.read<AuthBloc>().add(
    AuthEvent.emailChanged(_emailController.text),
  );

  void _onOtpChanged() => context.read<AuthBloc>().add(
    AuthEvent.otpCodeChanged(_otpController.text),
  );

  void _submit() {
    final bloc = context.read<AuthBloc>();
    bloc.add(
      bloc.state.step == AuthStep.email
          ? const AuthEvent.submitEmail()
          : const AuthEvent.submitOtp(),
    );
  }

  Future<void> _onStateChanged(BuildContext context, AuthState state) async {
    if (state.status case ErrorStateStatus(:final failure)) {
      await handleFailure(failure, context);
      return;
    }
    if (state.status.isSuccess && state.step == AuthStep.success) {
      context.read<CoreNavigationBloc>().add(
        const CoreNavigationEvent.authenticated(),
      );
    }
  }
}
