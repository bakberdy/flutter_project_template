import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:flutter/material.dart';

class BottomSheetList extends StatefulWidget {
  const BottomSheetList({
    required this.items,
    required this.divider,
    super.key,
    this.isScrollable = false,
    this.title,
    this.footer,
  });
  final List<BottomSheetListItem> items;
  final bool isScrollable;
  final Widget divider;
  final String? title;
  final Widget? footer;

  @override
  State<BottomSheetList> createState() => _BottomSheetListState();
}

class _BottomSheetListState extends State<BottomSheetList> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final footer = widget.footer;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        if (title != null) ...[
          Text(title, style: context.designTextTheme.titleMedium),
          const SizedBox(height: 10),
        ],
        ListView.separated(
          physics: widget.isScrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.items.length,
          separatorBuilder: (context, index) => widget.divider,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final onTap = item.onTap;
            return ListTile(
              onTap: onTap == null
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      onTap();
                    },
              leading: item.leading,
              trailing: item.trailing,
              title: item.label ?? Text(item.labelText ?? ''),
            );
          },
        ),
        ?footer,
      ],
    );
  }
}

class BottomSheetListItem {
  const BottomSheetListItem({
    this.label,
    this.onTap,
    this.leading,
    this.trailing,
    this.labelText,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget? label;
  final String? labelText;
  final VoidCallback? onTap;
}
