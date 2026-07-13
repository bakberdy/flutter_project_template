import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AdminInnerOneScreen extends StatelessWidget {
  const AdminInnerOneScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Inner Tab Screen 1')));
}

@RoutePage()
class AdminInnerTwoScreen extends StatelessWidget {
  const AdminInnerTwoScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Inner Tab Screen 2')));
}
