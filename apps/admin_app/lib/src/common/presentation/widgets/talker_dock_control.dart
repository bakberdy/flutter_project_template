import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/common/presentation/widgets/talker_dock_button.dart';
import 'package:admin_app/src/common/presentation/widgets/talker_dock_swap_button.dart';
import 'package:flutter/material.dart';

class TalkerDockControl extends StatelessWidget {
  const TalkerDockControl({
    required this.dockRight,
    required this.onSwapDockSide,
    required this.openTalker,
    super.key,
  });

  final bool dockRight;
  final VoidCallback onSwapDockSide;
  final VoidCallback openTalker;

  @override
  Widget build(BuildContext context) => Align(
    alignment: dockRight ? Alignment.bottomRight : Alignment.bottomLeft,
    child: SafeArea(
      minimum: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!dockRight)
            TalkerDockSwapButton(
              dockedRight: dockRight,
              label: context.l10n.devTalkerDockLeft,
              onPressed: onSwapDockSide,
            ),
          TalkerDockButton(openTalker: openTalker),
          if (dockRight)
            TalkerDockSwapButton(
              dockedRight: dockRight,
              label: context.l10n.devTalkerDockRight,
              onPressed: onSwapDockSide,
            ),
        ],
      ),
    ),
  );
}
