import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/src/localization/shared_localization_context_x.dart';

extension FailureUiX on Failure {
  String messageTextOrDefault(BuildContext context) {
    final l10n = context.l10n;
    final backendMessage = message?.trim();
    if (reason == FailureReason.backend &&
        backendMessage != null &&
        backendMessage.isNotEmpty) {
      return backendMessage;
    }

    return switch (reason) {
      FailureReason.noConnection => l10n.errorNoConnection,
      FailureReason.timeout => l10n.errorTimeout,
      FailureReason.serviceUnavailable => l10n.errorServiceUnavailable,
      FailureReason.secureConnection => l10n.errorSecureConnection,
      FailureReason.invalidResponse => l10n.errorInvalidResponse,
      FailureReason.requestFailed => l10n.errorRequestFailed,
      FailureReason.unauthorized => l10n.errorUnauthorized,
      FailureReason.backend => l10n.errorRequestFailed,
      FailureReason.cancelled || FailureReason.unknown =>
        details?.statusCode == 0 ? l10n.errorNoConnection : l10n.errorUnknown,
    };
  }
}
