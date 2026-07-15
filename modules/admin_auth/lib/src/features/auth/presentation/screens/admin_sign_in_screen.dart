import 'package:admin_auth/src/common/admin_auth_context_x.dart';
import 'package:admin_auth/src/common/config/router/admin_auth_router.dart';
import 'package:admin_auth/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
    with UiFailureHandlerMixin {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

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
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listenWhen: (previous, current) {
      if (current.status.isError && previous.status != current.status) {
        return true;
      }
      return current.status.isSuccess &&
          current.step == AuthStep.otp &&
          (!previous.status.isSuccess || previous.step != AuthStep.otp);
    },
    listener: (context, state) async {
      switch (state.status) {
        case ErrorStateStatus(:final failure):
          await handleFailure(failure, context);
          _emailFocusNode.requestFocus();
        case SuccessStateStatus():
          if (state.step == AuthStep.otp) {
            await context.router.push(const AdminOtpRoute());
          }
        default:
          break;
      }
    },
    builder: (context, state) {
      final canSubmit = state.emailField.value?.trim().isNotEmpty ?? false;
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 400,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(DesignSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.authTitle,
                        style: context.designTextTheme.headlineMedium,
                      ),
                      const SizedBox(height: DesignSpacing.lg),
                      BaseInputField(
                        label: context.l10n.authEmailLabel,
                        autofocus: true,
                        style: context.designTextTheme.bodyMedium,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (_) {
                          if (canSubmit) {
                            context.read<AuthBloc>().add(
                              const AuthEvent.submitEmail(),
                            );
                          }
                        },
                        errorText: state.emailField.error,
                      ),
                      const SizedBox(height: DesignSpacing.md),
                      BaseButton.primary(
                        label: context.l10n.authSubmitEmail,
                        loading: state.status.isLoading,
                        disabled: !canSubmit,
                        onPressed: () => context.read<AuthBloc>().add(
                          const AuthEvent.submitEmail(),
                        ),
                      ),
                      const SizedBox(height: DesignSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
