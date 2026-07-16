import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:client_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthOtpScreen extends StatefulWidget {
  const AuthOtpScreen({super.key});

  @override
  State<AuthOtpScreen> createState() => _AuthOtpScreenState();
}

class _AuthOtpScreenState extends State<AuthOtpScreen>
    with UiFailureHandlerMixin {
  final TextEditingController _otpCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _otpCodeController.addListener(() {
      context.read<AuthBloc>().add(
        AuthEvent.otpCodeChanged(_otpCodeController.text),
      );
    });
  }

  @override
  void dispose() {
    _otpCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        if (current.status.isError && previous.status != current.status) {
          return true;
        }
        return false;
      },
      listener: (context, state) async {
        switch (state.status) {
          case ErrorStateStatus(:final failure):
            await handleFailure(failure, context);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final canSubmit = state.otpCodeField.value?.trim().length == 6;
        return PopScope(
          onPopInvokedWithResult: (_, _) async {
            context.read<AuthBloc>().add(const AuthEvent.backToEmail());
            await context.router.maybePop();
          },
          child: Scaffold(
            appBar: AppBar(title: Text(l10n.authTitle)),
            body: Padding(
              padding: const EdgeInsets.all(DesignSpacingTokens.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BaseOtpTextField(
                    controller: _otpCodeController,
                    errorText: state.otpCodeField.error,
                  ),
                  const SizedBox(height: DesignSpacingTokens.md),
                  BaseButton.primary(
                    label: l10n.authSubmitOtp,
                    loading: state.status.isLoading,
                    disabled: !canSubmit,
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEvent.submitOtp());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
