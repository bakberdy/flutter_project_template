import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shared/src/extensions/failure_ui_x.dart';
import 'package:shared/src/localization/shared_localization_context_x.dart';

mixin UiFailureHandlerMixin {
  Future<void> handleFailure(Failure failure, BuildContext context) async {
    final l10n = context.l10n;
    final message = failure.messageTextOrDefault(context);

    switch (failure.details?.type) {
      case FailureType.alert:
        await BaseDialog.show<void>(
          context,
          title: message,
          primaryLabel: l10n.commonOk,
        );
      case FailureType.snackbar:
        BaseSnackbar.error(context, message: message);
      case FailureType.banner:
        _showBanner(context, message, l10n.commonDismiss);
      case FailureType.fullScreen:
        await _showFullscreen(context, message);
      case FailureType.inline:
      case FailureType.silent:
        break;
      case null:
        BaseSnackbar.error(context, message: message);
    }
  }

  void _showBanner(BuildContext context, String message, String dismissLabel) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: messenger.hideCurrentMaterialBanner,
              child: Text(dismissLabel),
            ),
          ],
        ),
      );
  }

  Future<void> _showFullscreen(BuildContext context, String message) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, animation, _, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      ),
      pageBuilder: (dialogContext, _, _) {
        return PopScope(
          canPop: false,
          child: Dialog.fullscreen(
            child: Scaffold(
              appBar: AppBar(
                title: Text(message),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              body: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
