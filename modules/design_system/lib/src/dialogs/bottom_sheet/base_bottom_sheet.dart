import 'package:design_system/src/buttons/base_button.dart';
import 'package:design_system/src/dialogs/bottom_sheet/bottom_sheet_list.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet {
  BaseBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    String? routeName,
    List<BaseButton>? actions,
    double? actionsSpacing,
    String? title,
    bool? rootNavigator,
  }) async {
    final result = await showModalBottomSheet<T>(
      useRootNavigator: rootNavigator ?? false,
      routeSettings: RouteSettings(name: routeName),
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      context: context,
      isDismissible: isDismissible,
      useSafeArea: true,
      backgroundColor: context.designBottomSheetTheme.backgroundColor,
      builder: (context) {
        final mediaQuery = MediaQuery.sizeOf(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: context.designSpacing.sm),
            Divider(
              height: 3,
              radius: BorderRadius.circular(context.designRadii.xs),
              thickness: 4,
              color: context.designColors.onSurface,
              indent: mediaQuery.width / 2 - 30,
              endIndent: mediaQuery.width / 2 - 30,
            ),
            SizedBox(height: context.designSpacing.sm),
            if (title != null) ...[
              Text(title, style: context.designTextTheme.titleMedium),
              SizedBox(height: context.designSpacing.md),
            ],
            builder(context),
            SizedBox(height: context.designSpacing.md),
            if (actions != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.designSpacing.md,
                ),
                child: Row(
                  spacing: actionsSpacing ?? context.designSpacing.xs,
                  children: actions
                      .map((action) => Expanded(child: action))
                      .toList(),
                ),
              ),
            SizedBox(height: context.designSpacing.lg),
          ],
        );
      },
    );
    return result;
  }

  static Future<void> showList({
    required BuildContext context,
    required List<BottomSheetListItem> items,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    bool isScrollable = false,
    Widget divider = const Divider(height: 1),
    String? title,
    Widget? footer,
    String? routeName,
    bool? rootNavigator,
  }) async {
    await show(
      rootNavigator: rootNavigator,
      routeName: routeName,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      context: context,
      builder: (context) => BottomSheetList(
        items: items,
        isScrollable: isScrollable,
        divider: divider,
        title: title,
        footer: footer,
      ),
      enableDrag: enableDrag,
    );
  }
}
