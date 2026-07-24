import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/src/localization/shared_localization_context_x.dart';

extension FailureUiX on Failure {
  String messageTextOrDefault(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      BackendFailure(:final message) when message.trim().isNotEmpty =>
        message.trim(),
      BackendFailure() || RequestFailedFailure() => l10n.errorRequestFailed,
      NoConnectionFailure() => l10n.errorNoConnection,
      TimeoutFailure() => l10n.errorTimeout,
      ServiceUnavailableFailure() => l10n.errorServiceUnavailable,
      SecureConnectionFailure() => l10n.errorSecureConnection,
      InvalidResponseFailure() => l10n.errorInvalidResponse,
      UnauthorizedFailure() => l10n.errorUnauthorized,
      GetAppInfoFailure() => l10n.errorGetAppInfo,
      GetDeviceInfoFailure() => l10n.errorGetDeviceInfo,
      RequestCancelledFailure() || UnknownFailure() => l10n.errorUnknown,
      _ => l10n.errorUnknown,
    };
  }
}
