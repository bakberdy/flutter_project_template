import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/common/config/router/client_auth_router.dart';
import 'package:client_auth/src/common/presentation/extensions/client_auth_context_x.dart';
import 'package:client_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class AuthEmailScreen extends StatefulWidget {
  const AuthEmailScreen({super.key});

  @override
  State<AuthEmailScreen> createState() => _AuthEmailScreenState();
}

class _AuthEmailScreenState extends State<AuthEmailScreen>
    with UiFailureHandlerMixin {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      context.read<AuthBloc>().add(
        AuthEvent.emailChanged(_emailController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        if (current.status.isError && previous.status != current.status) {
          return true;
        }
        if (current.status.isSuccess &&
            current.step == AuthStep.otp &&
            (!previous.status.isSuccess || previous.step != AuthStep.otp)) {
          return true;
        }
        return false;
      },
      listener: (context, state) async {
        switch (state.status) {
          case ErrorStateStatus(:final failure):
            await handleFailure(failure, context);
          case SuccessStateStatus():
            if (state.step == AuthStep.otp) {
              await context.router.push(const AuthOtpRoute());
            }
          default:
            break;
        }
      },
      builder: (context, state) {
        final canSubmit = state.emailField.value?.trim().isNotEmpty ?? false;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.authTitle)),
          body: Padding(
            padding: const EdgeInsets.all(DesignSpacingTokens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseInputField(
                  label: l10n.authEmailLabel,
                  style: context.designTextTheme.bodyMedium,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: state.emailField.error,
                ),
                const SizedBox(height: DesignSpacingTokens.md),
                BaseButton.primary(
                  label: l10n.authSubmitEmail,
                  loading: state.status.isLoading,
                  disabled: !canSubmit,
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEvent.submitEmail());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
