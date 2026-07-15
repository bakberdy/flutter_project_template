import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shared/src/mappers/ui_failure_mapper.dart';

mixin UiFailureHandlerMixin {
  Future<void> handleFailure(Failure failure, BuildContext context) async {
    final message = UiFailureMapper.message(failure);

    switch (failure.details?.type) {
      case FailureType.alert:
        await BaseDialog.show<void>(
          context,
          title: message,
          primaryLabel: 'OK',
        );
      case FailureType.snackbar:
        BaseSnackbar.error(context, message: message);
      case FailureType.banner:
        _showBanner(context, message);
      case FailureType.fullScreen:
        await _showFullscreen(context, message);
      case FailureType.inline:
      case FailureType.silent:
        break;
      case null:
        BaseSnackbar.error(context, message: message);
    }
  }

  void _showBanner(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: messenger.hideCurrentMaterialBanner,
              child: const Text('Dismiss'),
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
