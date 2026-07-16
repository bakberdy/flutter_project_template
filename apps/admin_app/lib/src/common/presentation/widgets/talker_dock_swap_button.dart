import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TalkerDockSwapButton extends StatelessWidget {
  const TalkerDockSwapButton({
    required this.dockedRight,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final bool dockedRight;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Semantics(
      label: label,
      button: true,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Material(
          color: context.designColors.surfaceBright,
          elevation: 0,
          shape: const CircleBorder(),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              dockedRight ? Icons.chevron_left : Icons.chevron_right,
              size: 30,
            ),
            color: context.designColors.primary,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    ),
  );
}
