import 'package:flutter/material.dart';

abstract final class DesignShadows {
  static List<BoxShadow> xs(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.08),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> sm(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.10),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> md(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.12),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> lg(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.14),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
