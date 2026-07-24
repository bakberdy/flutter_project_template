import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({
    required this.showTalkerDock,
    required this.onOpenTalker,
    required this.child,
    required this.bannerColor,
    required this.environment,
    this.debugMode = kDebugMode,
    super.key,
  });

  final ValueNotifier<bool> showTalkerDock;
  final VoidCallback onOpenTalker;
  final Widget child;
  final Color bannerColor;
  final String environment;
  final bool debugMode;

  @override
  Widget build(BuildContext context) {
    final isDevelopment = environment.trim().toLowerCase() == 'development';
    if (!isDevelopment && !debugMode) {
      return child;
    }

    return Stack(
      children: [
        Inspector(isEnabled: true, child: child),
        ValueListenableBuilder<bool>(
          valueListenable: showTalkerDock,
          builder: (context, showTalkerDock, _) {
            if (!showTalkerDock) return const SizedBox.shrink();

            return Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.small(
                onPressed: onOpenTalker,
                child: const Icon(Icons.bug_report_outlined),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: Banner(
            message: environment,
            location: BannerLocation.topEnd,
            color: bannerColor,
          ),
        ),
      ],
    );
  }
}
