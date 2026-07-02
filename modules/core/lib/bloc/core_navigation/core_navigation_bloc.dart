import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_navigation_bloc.freezed.dart';
part 'core_navigation_command.dart';
part 'core_navigation_event.dart';
part 'core_navigation_match.dart';
part 'core_navigation_route.dart';
part 'core_navigation_state.dart';

class CoreNavigationBloc
    extends Bloc<CoreNavigationEvent, CoreNavigationState> {
  CoreNavigationBloc() : super(const CoreNavigationState()) {
    on<_PushRequested>(_onPushRequested);
    on<_ReplaceRequested>(_onReplaceRequested);
    on<_ReplaceAllRequested>(_onReplaceAllRequested);
    on<_PopRequested>(_onPopRequested);
    on<_PopUntilRequested>(_onPopUntilRequested);
    on<_DeepLinkReceived>(_onDeepLinkReceived);
    on<_CommandHandled>(_onCommandHandled);
    on<_StackSynchronized>(_onStackSynchronized);
  }

  int _nextCommandId = 0;

  void _onPushRequested(
    _PushRequested event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(
      state.copyWith(
        stack: [...state.stack, event.route],
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.push(
            id: _createCommandId(),
            route: event.route,
          ),
        ],
      ),
    );
  }

  void _onReplaceRequested(
    _ReplaceRequested event,
    Emitter<CoreNavigationState> emit,
  ) {
    final stack = [...state.stack];
    if (stack.isEmpty) {
      stack.add(event.route);
    } else {
      stack[stack.length - 1] = event.route;
    }

    emit(
      state.copyWith(
        stack: stack,
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.replace(
            id: _createCommandId(),
            route: event.route,
          ),
        ],
      ),
    );
  }

  void _onReplaceAllRequested(
    _ReplaceAllRequested event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(
      state.copyWith(
        stack: event.routes,
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.replaceAll(
            id: _createCommandId(),
            routes: event.routes,
          ),
        ],
      ),
    );
  }

  void _onPopRequested(_PopRequested event, Emitter<CoreNavigationState> emit) {
    final stack = [...state.stack];
    if (stack.isNotEmpty) {
      stack.removeLast();
    }

    emit(
      state.copyWith(
        stack: stack,
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.pop(
            id: _createCommandId(),
            result: event.result,
          ),
        ],
      ),
    );
  }

  void _onPopUntilRequested(
    _PopUntilRequested event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(
      state.copyWith(
        stack: _stackUntil(event.match),
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.popUntil(
            id: _createCommandId(),
            match: event.match,
          ),
        ],
      ),
    );
  }

  void _onDeepLinkReceived(
    _DeepLinkReceived event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(
      state.copyWith(
        lastDeepLink: event.uri,
        pendingCommands: [
          ...state.pendingCommands,
          CoreNavigationCommand.openDeepLink(
            id: _createCommandId(),
            uri: event.uri,
          ),
        ],
      ),
    );
  }

  void _onCommandHandled(
    _CommandHandled event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(
      state.copyWith(
        pendingCommands: state.pendingCommands
            .where((command) => command.id != event.commandId)
            .toList(growable: false),
      ),
    );
  }

  void _onStackSynchronized(
    _StackSynchronized event,
    Emitter<CoreNavigationState> emit,
  ) {
    emit(state.copyWith(stack: event.stack));
  }

  List<CoreNavigationRoute> _stackUntil(CoreNavigationMatch match) {
    final stack = [...state.stack];
    final index = stack.lastIndexWhere(match.matches);
    if (index == -1) {
      return stack;
    }
    return stack.take(index + 1).toList(growable: false);
  }

  int _createCommandId() => _nextCommandId++;
}
