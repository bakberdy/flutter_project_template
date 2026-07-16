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
        borderRadius: BorderRadius.circular(context.designRadii.sm),
        side: BorderSide(color: context.designColors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.designSpacing.lg),
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
            SizedBox(height: context.designSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final row in rows) ...[
                  row,
                  if (row != rows.last)
                    SizedBox(height: context.designSpacing.md),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
