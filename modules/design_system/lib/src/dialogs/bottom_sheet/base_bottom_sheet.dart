import 'package:design_system/src/buttons/base_button.dart';
import 'package:design_system/src/dialogs/bottom_sheet/bottom_sheet_list.dart';
import 'package:design_system/src/tokens/design_radii.dart';
import 'package:design_system/src/tokens/design_spacing.dart';
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
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        final mediaQuery = MediaQuery.sizeOf(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: DesignSpacing.sm),
            Divider(
              height: 3,
              radius: BorderRadius.circular(DesignRadii.xs),
              thickness: 4,
              color: Theme.of(context).colorScheme.onSurface,
              indent: mediaQuery.width / 2 - 30,
              endIndent: mediaQuery.width / 2 - 30,
            ),
            const SizedBox(height: DesignSpacing.sm),
            if (title != null) ...[
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: DesignSpacing.md),
            ],
            builder(context),
            const SizedBox(height: DesignSpacing.md),
            if (actions != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSpacing.md,
                ),
                child: Row(
                  spacing: actionsSpacing ?? DesignSpacing.xs,
                  children: actions
                      .map((action) => Expanded(child: action))
                      .toList(),
                ),
              ),
            const SizedBox(height: DesignSpacing.lg),
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
