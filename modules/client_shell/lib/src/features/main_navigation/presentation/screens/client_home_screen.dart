import 'package:auto_route/auto_route.dart';
import 'package:client_shell/gen/l10n/client_shell_localizations.dart';
import 'package:client_shell/src/features/main_navigation/presentation/providers/scroll_to_top_provider.dart';
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
    appBar: AppBar(title: Text(ClientShellLocalizations.of(context).home)),
    body: ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(
        title: Text(ClientShellLocalizations.of(context).homeItem(index + 1)),
      ),
    ),
  );

  void _animateToTop() {
    if (!_scrollController.hasClients) {
      return;
    }
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}
