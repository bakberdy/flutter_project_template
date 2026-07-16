import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key, required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignRadiusTokens.sm),
        side: BorderSide(color: context.designColors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignSpacingTokens.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: context.designTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: DesignSpacingTokens.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final row in rows) ...[
                  row,
                  if (row != rows.last)
                    const SizedBox(height: DesignSpacingTokens.md),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
