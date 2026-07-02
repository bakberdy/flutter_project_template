import 'package:flutter/material.dart';

class BottomSheetList extends StatefulWidget {
  const BottomSheetList({
    super.key,
    required this.items,
    this.isScrollable = false,
    required this.divider,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        if (widget.title != null) ...[
          Text(widget.title!, style: Theme.of(context).textTheme.titleMedium),
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
            return ListTile(
              onTap: item.onTap == null
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      item.onTap!();
                    },
              leading: item.leading,
              trailing: item.trailing,
              title: item.label ?? Text(item.labelText ?? ''),
            );
          },
        ),
        if (widget.footer != null) widget.footer!,
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
