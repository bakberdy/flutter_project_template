import 'package:auto_route/auto_route.dart';
import 'package:client_app/router/client_app_router.dart';
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
          onTap: () => context.read<CoreNavigationBloc>().add(
            CoreNavigationEvent.push(
              SamplePushRoute(id: 'root-1', key: ValueKey('root-1')),
            ),
          ),
        ),
        _SampleAction(
          title: 'Push shell initial child',
          subtitle: 'Pushes a nested stack shell at its initial child.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.push(SampleShellRoute()),
          ),
        ),
        _SampleAction(
          title: 'Push shell details',
          subtitle: 'Pushes a shell route with a nested details child.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            CoreNavigationEvent.push(
              SampleShellRoute(
                children: [
                  SampleShellDetailsRoute(
                    id: 'shell-42',
                    key: ValueKey('shell-42'),
                  ),
                ],
              ),
            ),
          ),
        ),
        _SampleAction(
          title: 'Push tab shell',
          subtitle: 'Shows a tab shell with independent child routers.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.push(SampleTabsRoute()),
          ),
        ),
        _SampleAction(
          title: 'Push tab details',
          subtitle: 'Pushes a tab shell with a details route in the first tab.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            CoreNavigationEvent.push(
              SampleTabsRoute(
                children: [
                  SampleTabOneShellRoute(
                    children: [SampleTabOneDetailsRoute(id: 'tab-7')],
                  ),
                ],
              ),
            ),
          ),
        ),
        _SampleAction(
          title: 'Push with result',
          subtitle: 'Pushes a page that pops with a result through core nav.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.push(SampleResultPickerRoute()),
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
          onPressed: () => context.read<CoreNavigationBloc>().add(
            CoreNavigationEvent.push(
              SamplePushRoute(id: 'root-2', key: ValueKey('root-2')),
            ),
          ),
          child: const Text('Push another root screen'),
        ),
        OutlinedButton(
          onPressed: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.pop(),
          ),
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
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.push(
            SampleShellRoute(
              children: [
                SampleShellDetailsRoute(
                  id: 'child-1',
                  key: ValueKey('child-1'),
                ),
              ],
            ),
          ),
        ),
        child: const Text('Push shell child'),
      ),
      OutlinedButton(
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.push(SamplePushRoute(id: 'from-shell')),
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
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.replace(SamplePushRoute(id: 'replaced-shell')),
        ),
        child: const Text('Replace shell with root screen'),
      ),
      OutlinedButton(
        onPressed: () => context.read<CoreNavigationBloc>().add(
          const CoreNavigationEvent.pop(),
        ),
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
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.push(SampleTabOneDetailsRoute(id: 'tab-one-1')),
        ),
        child: const Text('Push tab details route'),
      ),
      OutlinedButton(
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.push(SamplePushRoute(id: 'from-tab')),
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
        onPressed: () => context.read<CoreNavigationBloc>().add(
          CoreNavigationEvent.push(
            SampleTabsRoute(
              children: [
                SampleTabOneShellRoute(
                  children: [SampleTabOneDetailsRoute(id: 'tab-one-2')],
                ),
              ],
            ),
          ),
        ),
        child: const Text('Push another tab details route'),
      ),
      OutlinedButton(
        onPressed: () => context.read<CoreNavigationBloc>().add(
          const CoreNavigationEvent.pop(),
        ),
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
        onPressed: () => context.read<CoreNavigationBloc>().add(
          const CoreNavigationEvent.push(SampleResultPickerRoute()),
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
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.pop(result: 'approved'),
          ),
        ),
        _SampleAction(
          title: 'Return declined',
          subtitle: 'Pops this route with a different String result.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.pop(result: 'declined'),
          ),
        ),
        _SampleAction(
          title: 'Cancel',
          subtitle: 'Pops this route without a result.',
          onTap: () => context.read<CoreNavigationBloc>().add(
            const CoreNavigationEvent.pop(),
          ),
        ),
      ],
    ),
  );
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
