import 'package:flutter/material.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: Padding(padding: padding, child: child),
  );
}
