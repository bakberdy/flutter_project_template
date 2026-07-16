import 'package:flutter/widgets.dart';

class ScrollToTopProvider extends InheritedWidget {
  const ScrollToTopProvider({
    required super.child,
    required this.onScrollToTop,
    required this.onRegisterCallback,
    super.key,
  });

  final VoidCallback onScrollToTop;
  final ValueChanged<VoidCallback> onRegisterCallback;

  static ScrollToTopProvider? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScrollToTopProvider>();

  @override
  bool updateShouldNotify(ScrollToTopProvider oldWidget) => false;
}
