import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TalkerDockButton extends StatelessWidget {
  const TalkerDockButton({required this.openTalker, super.key});

  final VoidCallback openTalker;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [context.designColors.primary, context.designColors.tertiary],
      ),
      borderRadius: BorderRadius.circular(999),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 8)),
      ],
    ),
    child: FilledButton.icon(
      onPressed: openTalker,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: context.designColors.onPrimary,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      icon: const Icon(Icons.bug_report_outlined, size: 18),
      label: Text(
        context.l10n.devTalkerOpen,
        style: context.designTextTheme.labelLarge?.copyWith(
          color: context.designColors.onPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
