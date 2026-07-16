import 'package:admin_auth/src/common/admin_auth_context_x.dart';
import 'package:admin_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class AdminOtpScreen extends StatefulWidget {
  const AdminOtpScreen({super.key});

  @override
  State<AdminOtpScreen> createState() => _AdminOtpScreenState();
}

class _AdminOtpScreenState extends State<AdminOtpScreen>
    with UiFailureHandlerMixin {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() {
      context.read<AuthBloc>().add(
        AuthEvent.otpCodeChanged(_otpController.text),
      );
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listenWhen: (previous, current) =>
        current.status.isError && previous.status != current.status,
    listener: (context, state) async {
      if (state.status case ErrorStateStatus(:final failure)) {
        await handleFailure(failure, context);
        _otpFocusNode.requestFocus();
      }
    },
    builder: (context, state) {
      final canSubmit = state.otpCodeField.value?.trim().length == 6;
      return PopScope(
        onPopInvokedWithResult: (_, _) =>
            context.read<AuthBloc>().add(const AuthEvent.backToEmail()),
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              child: Card(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(DesignSpacingTokens.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 50),
                          BaseOtpTextField(
                            controller: _otpController,
                            errorText: state.otpCodeField.error,
                            focusNode: _otpFocusNode,
                            onSubmitted: (_) {
                              if (canSubmit) {
                                context.read<AuthBloc>().add(
                                  const AuthEvent.submitOtp(),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: DesignSpacingTokens.md),
                          BaseButton.primary(
                            label: context.l10n.authSubmitOtp,
                            loading: state.status.isLoading,
                            disabled: !canSubmit,
                            onPressed: () => context.read<AuthBloc>().add(
                              const AuthEvent.submitOtp(),
                            ),
                          ),
                          const SizedBox(height: DesignSpacingTokens.lg),
                        ],
                      ),
                    ),
                    Positioned(
                      top: DesignSpacingTokens.lg,
                      left: DesignSpacingTokens.md,
                      child: Row(
                        children: [
                          BackButton(
                            color: context.designColors.onSurface,
                            onPressed: () async {
                              context.read<AuthBloc>().add(
                                const AuthEvent.backToEmail(),
                              );
                              await context.router.maybePop();
                            },
                          ),
                          Text(
                            context.l10n.authTitle,
                            style: context.designTextTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
