import 'package:flutter/widgets.dart';

class SystemBrightnessObserver extends StatefulWidget {
  const SystemBrightnessObserver({
    required this.onInitialBrightness,
    required this.onBrightnessChanged,
    required this.child,
    super.key,
  });

  final ValueChanged<Brightness> onInitialBrightness;
  final ValueChanged<Brightness> onBrightnessChanged;
  final Widget child;

  @override
  State<SystemBrightnessObserver> createState() =>
      _SystemBrightnessObserverState();
}

class _SystemBrightnessObserverState extends State<SystemBrightnessObserver>
    with WidgetsBindingObserver {
  Brightness get _platformBrightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onInitialBrightness(_platformBrightness);
  }

  @override
  void didChangePlatformBrightness() {
    widget.onBrightnessChanged(_platformBrightness);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onBrightnessChanged(_platformBrightness);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
