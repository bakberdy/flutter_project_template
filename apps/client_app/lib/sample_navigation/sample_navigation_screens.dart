import 'package:auto_route/auto_route.dart';
import 'package:client_app/sample_navigation/sample_navigation_routes.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SampleHomeScreen extends StatelessWidget {
  const SampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => _SampleScaffold(
    title: 'Sample navigation',
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SampleAction(
          title: 'Push root screen',
          subtitle: 'Pushes a normal page on the root stack.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(
              name: SampleNavigationRoutes.push,
              pathParameters: {'id': 'root-1'},
            ),
          ),
        ),
        _SampleAction(
          title: 'Open shell initial child',
          subtitle: 'Opens a nested stack shell at its initial child.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(name: SampleNavigationRoutes.shell),
          ),
        ),
        _SampleAction(
          title: 'Open shell details',
          subtitle: 'Deep-links into a nested child with a path parameter.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(
              name: SampleNavigationRoutes.shellDetails,
              pathParameters: {'id': 'shell-42'},
            ),
          ),
        ),
        _SampleAction(
          title: 'Open tab shell',
          subtitle: 'Shows a tab shell with independent child routers.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(name: SampleNavigationRoutes.tabs),
          ),
        ),
        _SampleAction(
          title: 'Open tab child details',
          subtitle: 'Deep-links into a child route inside the first tab.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(
              name: SampleNavigationRoutes.tabOneDetails,
              pathParameters: {'id': 'tab-7'},
            ),
          ),
        ),
        _SampleAction(
          title: 'Push with result',
          subtitle: 'Pushes a page that pops with a result through core nav.',
          onTap: () => context.pushSampleRoute(
            const CoreNavigationRoute(
              name: SampleNavigationRoutes.resultPicker,
            ),
          ),
        ),
      ],
    ),
  );
}

@RoutePage()
class SamplePushScreen extends StatelessWidget {
  const SamplePushScreen({@PathParam('id') required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) => _SampleScaffold(
    title: 'Root push',
    body: _SampleDetailsBody(
      title: 'Root stack screen',
      value: id,
      actions: [
        FilledButton(
          onPressed: () => context.pushSampleRoute(
            const CoreNavigationRoute(
              name: SampleNavigationRoutes.push,
              pathParameters: {'id': 'root-2'},
            ),
          ),
          child: const Text('Push another root screen'),
        ),
        OutlinedButton(
          onPressed: () => context.popSampleRoute(),
          child: const Text('Pop'),
        ),
      ],
    ),
  );
}

@RoutePage()
class SampleShellScreen extends StatelessWidget {
  const SampleShellScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Nested shell'),
      leading: const AutoLeadingButton(),
    ),
    body: const AutoRouter(),
  );
}

@RoutePage()
class SampleShellHomeScreen extends StatelessWidget {
  const SampleShellHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => _SampleDetailsBody(
    title: 'Shell initial child',
    value: 'This screen is rendered inside SampleShellRoute.',
    actions: [
      FilledButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.shellDetails,
            pathParameters: {'id': 'child-1'},
          ),
        ),
        child: const Text('Push shell child'),
      ),
      OutlinedButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.push,
            pathParameters: {'id': 'from-shell'},
          ),
        ),
        child: const Text('Push root from shell'),
      ),
    ],
  );
}

@RoutePage()
class SampleShellDetailsScreen extends StatelessWidget {
  const SampleShellDetailsScreen({
    @PathParam('id') required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) => _SampleDetailsBody(
    title: 'Shell details',
    value: id,
    actions: [
      FilledButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.shellDetails,
            pathParameters: {'id': 'child-2'},
          ),
        ),
        child: const Text('Replace sibling path'),
      ),
      OutlinedButton(
        onPressed: () => context.popSampleRoute(),
        child: const Text('Pop shell child'),
      ),
    ],
  );
}

@RoutePage()
class SampleTabsScreen extends StatelessWidget {
  const SampleTabsScreen({super.key});

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
    builder: (context, child) {
      final tabsRouter = AutoTabsRouter.of(context);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Tab shell'),
          leading: const AutoLeadingButton(),
        ),
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.looks_one_outlined),
              selectedIcon: Icon(Icons.looks_one),
              label: 'One',
            ),
            NavigationDestination(
              icon: Icon(Icons.looks_two_outlined),
              selectedIcon: Icon(Icons.looks_two),
              label: 'Two',
            ),
          ],
        ),
      );
    },
  );
}

@RoutePage()
class SampleTabOneShellScreen extends StatelessWidget {
  const SampleTabOneShellScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();
}

@RoutePage()
class SampleTabOneHomeScreen extends StatelessWidget {
  const SampleTabOneHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => _SampleDetailsBody(
    title: 'Tab one home',
    value: 'This tab owns its own nested stack.',
    actions: [
      FilledButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.tabOneDetails,
            pathParameters: {'id': 'tab-one-1'},
          ),
        ),
        child: const Text('Push tab child'),
      ),
      OutlinedButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.push,
            pathParameters: {'id': 'from-tab'},
          ),
        ),
        child: const Text('Push root from tab'),
      ),
    ],
  );
}

@RoutePage()
class SampleTabOneDetailsScreen extends StatelessWidget {
  const SampleTabOneDetailsScreen({
    @PathParam('id') required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) => _SampleDetailsBody(
    title: 'Tab one details',
    value: id,
    actions: [
      FilledButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(
            name: SampleNavigationRoutes.tabOneDetails,
            pathParameters: {'id': 'tab-one-2'},
          ),
        ),
        child: const Text('Push sibling details'),
      ),
      OutlinedButton(
        onPressed: () => context.popSampleRoute(),
        child: const Text('Pop tab child'),
      ),
    ],
  );
}

@RoutePage()
class SampleTabTwoScreen extends StatelessWidget {
  const SampleTabTwoScreen({super.key});

  @override
  Widget build(BuildContext context) => _SampleDetailsBody(
    title: 'Tab two',
    value: 'Second tab without nested children.',
    actions: [
      FilledButton(
        onPressed: () => context.pushSampleRoute(
          const CoreNavigationRoute(name: SampleNavigationRoutes.resultPicker),
        ),
        child: const Text('Push result picker on root'),
      ),
    ],
  );
}

@RoutePage()
class SampleResultPickerScreen extends StatelessWidget {
  const SampleResultPickerScreen({super.key});

  @override
  Widget build(BuildContext context) => _SampleScaffold(
    title: 'Result picker',
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SampleAction(
          title: 'Return approved',
          subtitle: 'Pops this route with a String result.',
          onTap: () => context.popSampleRoute('approved'),
        ),
        _SampleAction(
          title: 'Return declined',
          subtitle: 'Pops this route with a different String result.',
          onTap: () => context.popSampleRoute('declined'),
        ),
        _SampleAction(
          title: 'Cancel',
          subtitle: 'Pops this route without a result.',
          onTap: () => context.popSampleRoute(),
        ),
      ],
    ),
  );
}

extension _SampleNavigationBuildContextX on BuildContext {
  void pushSampleRoute(CoreNavigationRoute route) {
    read<CoreNavigationBloc>().add(CoreNavigationEvent.push(route));
  }

  void popSampleRoute([Object? result]) {
    read<CoreNavigationBloc>().add(CoreNavigationEvent.pop(result: result));
  }
}

class _SampleScaffold extends StatelessWidget {
  const _SampleScaffold({required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), leading: const AutoLeadingButton()),
    body: body,
  );
}

class _SampleDetailsBody extends StatelessWidget {
  const _SampleDetailsBody({
    required this.title,
    required this.value,
    required this.actions,
  });

  final String title;
  final String value;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(title, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      Text(value),
      const SizedBox(height: 24),
      ...actions.expand((action) => [action, const SizedBox(height: 12)]),
    ],
  );
}

class _SampleAction extends StatelessWidget {
  const _SampleAction({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
