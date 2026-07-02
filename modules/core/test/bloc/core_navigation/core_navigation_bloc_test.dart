import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const home = CoreNavigationRoute(name: 'home', path: '/');
  const details = CoreNavigationRoute(
    name: 'details',
    path: '/details',
    pathParameters: {'id': '1'},
  );

  group('CoreNavigationBloc', () {
    test('push updates the stack and queues a push command', () async {
      final bloc = CoreNavigationBloc();

      bloc.add(const CoreNavigationEvent.push(home));
      await expectLater(
        bloc.stream,
        emits(
          isA<CoreNavigationState>()
              .having((state) => state.stack, 'stack', [home])
              .having(
                (state) => state.nextCommand,
                'nextCommand',
                isA<PushNavigationCommand>()
                    .having((command) => command.id, 'id', 0)
                    .having((command) => command.route, 'route', home),
              ),
        ),
      );

      await bloc.close();
    });

    test('commandHandled removes the acknowledged pending command', () async {
      final bloc = CoreNavigationBloc();

      bloc.add(const CoreNavigationEvent.push(home));
      await expectLater(bloc.stream, emits(isA<CoreNavigationState>()));

      bloc.add(const CoreNavigationEvent.commandHandled(0));
      await expectLater(
        bloc.stream,
        emits(
          isA<CoreNavigationState>().having(
            (state) => state.pendingCommands,
            'pendingCommands',
            isEmpty,
          ),
        ),
      );

      await bloc.close();
    });

    test('replace changes the current route', () async {
      final bloc = CoreNavigationBloc();

      bloc
        ..add(const CoreNavigationEvent.push(home))
        ..add(const CoreNavigationEvent.replace(details));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<CoreNavigationState>().having((state) => state.stack, 'stack', [
            home,
          ]),
          isA<CoreNavigationState>()
              .having((state) => state.stack, 'stack', [details])
              .having(
                (state) => state.pendingCommands.last,
                'last command',
                isA<ReplaceNavigationCommand>().having(
                  (command) => command.route,
                  'route',
                  details,
                ),
              ),
        ]),
      );

      await bloc.close();
    });

    test('popUntil keeps the matched route as the top of the stack', () async {
      const settings = CoreNavigationRoute(name: 'settings', path: '/settings');
      final bloc = CoreNavigationBloc();

      bloc.add(const CoreNavigationEvent.replaceAll([home, details, settings]));
      await expectLater(bloc.stream, emits(isA<CoreNavigationState>()));

      bloc.add(
        const CoreNavigationEvent.popUntil(CoreNavigationMatch.name('details')),
      );
      await expectLater(
        bloc.stream,
        emits(
          isA<CoreNavigationState>().having((state) => state.stack, 'stack', [
            home,
            details,
          ]),
        ),
      );

      await bloc.close();
    });

    test(
      'deepLinkReceived queues a router-neutral deep link command',
      () async {
        final bloc = CoreNavigationBloc();
        final uri = Uri.parse('/profile?id=42');

        bloc.add(CoreNavigationEvent.deepLinkReceived(uri));
        await expectLater(
          bloc.stream,
          emits(
            isA<CoreNavigationState>()
                .having((state) => state.lastDeepLink, 'lastDeepLink', uri)
                .having(
                  (state) => state.nextCommand,
                  'nextCommand',
                  isA<OpenDeepLinkNavigationCommand>().having(
                    (command) => command.uri,
                    'uri',
                    uri,
                  ),
                ),
          ),
        );

        await bloc.close();
      },
    );
  });
}
