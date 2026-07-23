import 'package:flutter/material.dart';

@immutable
class DesignSemanticColors extends ThemeExtension<DesignSemanticColors> {
  const DesignSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.destructive,
    required this.onDestructive,
    required this.destructiveContainer,
    required this.onDestructiveContainer,
    required this.disabled,
    required this.onDisabled,
  });

  static const light = DesignSemanticColors(
    success: Color(0xFF16803C),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFD9FBE4),
    onSuccessContainer: Color(0xFF07391B),
    warning: Color(0xFF9A5B00),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFE2B8),
    onWarningContainer: Color(0xFF321B00),
    info: Color(0xFF2563EB),
    onInfo: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFDCE7FF),
    onInfoContainer: Color(0xFF071D49),
    destructive: Color(0xFFBA1A1A),
    onDestructive: Color(0xFFFFFFFF),
    destructiveContainer: Color(0xFFFFDAD6),
    onDestructiveContainer: Color(0xFF410002),
    disabled: Color(0xFFE2E2E6),
    onDisabled: Color(0xFF8A8A91),
  );

  static const dark = DesignSemanticColors(
    success: Color(0xFF75DB91),
    onSuccess: Color(0xFF003919),
    successContainer: Color(0xFF005226),
    onSuccessContainer: Color(0xFF91F8AA),
    warning: Color(0xFFFFB951),
    onWarning: Color(0xFF512E00),
    warningContainer: Color(0xFF744200),
    onWarningContainer: Color(0xFFFFDDB3),
    info: Color(0xFFADC6FF),
    onInfo: Color(0xFF002E69),
    infoContainer: Color(0xFF004494),
    onInfoContainer: Color(0xFFD9E2FF),
    destructive: Color(0xFFFFB4AB),
    onDestructive: Color(0xFF690005),
    destructiveContainer: Color(0xFF93000A),
    onDestructiveContainer: Color(0xFFFFDAD6),
    disabled: Color(0xFF45464D),
    onDisabled: Color(0xFF8E9099),
  );

  @override
  DesignSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? destructive,
    Color? onDestructive,
    Color? destructiveContainer,
    Color? onDestructiveContainer,
    Color? disabled,
    Color? onDisabled,
  }) => DesignSemanticColors(
    success: success ?? this.success,
    onSuccess: onSuccess ?? this.onSuccess,
    successContainer: successContainer ?? this.successContainer,
    onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    warning: warning ?? this.warning,
    onWarning: onWarning ?? this.onWarning,
    warningContainer: warningContainer ?? this.warningContainer,
    onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    info: info ?? this.info,
    onInfo: onInfo ?? this.onInfo,
    infoContainer: infoContainer ?? this.infoContainer,
    onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    destructive: destructive ?? this.destructive,
    onDestructive: onDestructive ?? this.onDestructive,
    destructiveContainer: destructiveContainer ?? this.destructiveContainer,
    onDestructiveContainer:
        onDestructiveContainer ?? this.onDestructiveContainer,
    disabled: disabled ?? this.disabled,
    onDisabled: onDisabled ?? this.onDisabled,
  );

  @override
  DesignSemanticColors lerp(covariant DesignSemanticColors? other, double t) {
    if (other == null) {
      return this;
    }
    return DesignSemanticColors(
      success: _lerpColor(success, other.success, t),
      onSuccess: _lerpColor(onSuccess, other.onSuccess, t),
      successContainer: _lerpColor(
        successContainer,
        other.successContainer,
        t,
      ),
      onSuccessContainer: _lerpColor(
        onSuccessContainer,
        other.onSuccessContainer,
        t,
      ),
      warning: _lerpColor(warning, other.warning, t),
      onWarning: _lerpColor(onWarning, other.onWarning, t),
      warningContainer: _lerpColor(
        warningContainer,
        other.warningContainer,
        t,
      ),
      onWarningContainer: _lerpColor(
        onWarningContainer,
        other.onWarningContainer,
        t,
      ),
      info: _lerpColor(info, other.info, t),
      onInfo: _lerpColor(onInfo, other.onInfo, t),
      infoContainer: _lerpColor(infoContainer, other.infoContainer, t),
      onInfoContainer: _lerpColor(onInfoContainer, other.onInfoContainer, t),
      destructive: _lerpColor(destructive, other.destructive, t),
      onDestructive: _lerpColor(onDestructive, other.onDestructive, t),
      destructiveContainer: _lerpColor(
        destructiveContainer,
        other.destructiveContainer,
        t,
      ),
      onDestructiveContainer: _lerpColor(
        onDestructiveContainer,
        other.onDestructiveContainer,
        t,
      ),
      disabled: _lerpColor(disabled, other.disabled, t),
      onDisabled: _lerpColor(onDisabled, other.onDisabled, t),
    );
  }

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color destructive;
  final Color onDestructive;
  final Color destructiveContainer;
  final Color onDestructiveContainer;
  final Color disabled;
  final Color onDisabled;
}

Color _lerpColor(Color begin, Color end, double t) =>
    Color.lerp(begin, end, t) ?? end;
