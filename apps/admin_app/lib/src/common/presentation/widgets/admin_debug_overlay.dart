import 'package:admin_app/src/common/presentation/widgets/talker_dock_control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminDebugOverlay extends StatefulWidget {
  const AdminDebugOverlay({
    required this.environment,
    required this.bannerColor,
    required this.showTalkerDock,
    required this.onOpenTalker,
    required this.child,
    super.key,
  });

  final String environment;
  final Color bannerColor;
  final ValueListenable<bool> showTalkerDock;
  final VoidCallback onOpenTalker;
  final Widget child;

  @override
  State<AdminDebugOverlay> createState() => _AdminDebugOverlayState();
}

class _AdminDebugOverlayState extends State<AdminDebugOverlay> {
  final ValueNotifier<bool> _dockRight = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _dockRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.environment == 'production' && !kDebugMode) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder<bool>(
          valueListenable: widget.showTalkerDock,
          builder: (context, showTalkerDock, _) {
            if (!showTalkerDock) {
              return const SizedBox.shrink();
            }
            return ValueListenableBuilder<bool>(
              valueListenable: _dockRight,
              builder: (context, dockRight, child) => TalkerDockControl(
                dockRight: dockRight,
                onSwapDockSide: () => _dockRight.value = !_dockRight.value,
                openTalker: widget.onOpenTalker,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: Banner(
            message: widget.environment,
            location: BannerLocation.topEnd,
            color: widget.bannerColor,
          ),
        ),
      ],
    );
  }
}
