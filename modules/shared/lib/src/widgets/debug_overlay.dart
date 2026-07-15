import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({
    required this.showTalkerDock,
    required this.onOpenTalker,
    required this.child,
    required this.bannerColor,
    required this.environment,
    super.key,
  });

  final ValueNotifier<bool> showTalkerDock;
  final VoidCallback onOpenTalker;
  final Widget child;
  final Color bannerColor;
  final String environment;

  @override
  Widget build(BuildContext context) {
    if (environment == 'production' && !kDebugMode) {
      return child;
    }

    return Stack(
      children: [
        child,
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
