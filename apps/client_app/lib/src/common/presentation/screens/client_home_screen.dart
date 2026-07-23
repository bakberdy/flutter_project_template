import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:client_app/src/common/presentation/providers/scroll_to_top_provider.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScrollToTopProvider.maybeOf(context)?.onRegisterCallback(_animateToTop);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.home)),
    body: ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
      itemCount: 20,
      itemBuilder: (context, index) =>
          ListTile(title: Text(context.l10n.homeItem(index + 1))),
    ),
  );

  void _animateToTop() {
    if (!_scrollController.hasClients) {
      return;
    }
    unawaited(
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
    );
  }
}
