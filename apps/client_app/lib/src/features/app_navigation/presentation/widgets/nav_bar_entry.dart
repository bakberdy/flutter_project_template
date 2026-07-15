import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBarEntry extends StatefulWidget {
  const NavBarEntry({
    required this.icon,
    required this.onTap,
    super.key,
    this.label,
    this.isSelected = false,
    this.width = 80,
  });

  final String? label;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  @override
  State<NavBarEntry> createState() => _NavBarEntryState();
}

class _NavBarEntryState extends State<NavBarEntry>
    with TickerProviderStateMixin {
  late final AnimationController _selectionController;
  late final Animation<double> _iconScale;
  late final AnimationController _tapController;
  late final Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _selectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _iconScale = Tween<double>(begin: 1, end: 1.1)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_selectionController);
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      reverseDuration: const Duration(milliseconds: 140),
    );
    _tapScale = Tween<double>(
      begin: 1,
      end: 0.9,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_tapController);
    if (widget.isSelected) {
      _selectionController.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant NavBarEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected == widget.isSelected) {
      return;
    }
    if (widget.isSelected) {
      unawaited(_selectionController.forward());
    } else {
      unawaited(_selectionController.reverse());
    }
  }

  @override
  void dispose() {
    _tapController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomTheme = context.designBottomNavigationBarTheme;
    final showLabel =
        widget.label != null &&
        (widget.isSelected
            ? bottomTheme.showSelectedLabels ?? true
            : bottomTheme.showUnselectedLabels ?? false);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _tapController.forward(from: 0),
      onTapUp: (_) async {
        await _tapController.reverse();
        if (bottomTheme.enableFeedback == true) {
          await HapticFeedback.lightImpact();
        }
        widget.onTap();
      },
      onTapCancel: _tapController.reverse,
      child: IconTheme(
        data: widget.isSelected
            ? bottomTheme.selectedIconTheme ?? const IconThemeData()
            : bottomTheme.unselectedIconTheme ?? const IconThemeData(),
        child: SizedBox(
          width: widget.width,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([
                  _selectionController,
                  _tapController,
                ]),
                builder: (context, child) => Transform.scale(
                  scale: _iconScale.value * _tapScale.value,
                  child: child,
                ),
                child: widget.icon,
              ),
              if (showLabel)
                AnimatedBuilder(
                  animation: _tapController,
                  builder: (context, child) =>
                      Transform.scale(scale: _tapScale.value, child: child),
                  child: Text(
                    widget.label!,
                    style: widget.isSelected
                        ? bottomTheme.selectedLabelStyle
                        : bottomTheme.unselectedLabelStyle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
