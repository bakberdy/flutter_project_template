class ApiCancelToken {
  final List<void Function(String? reason)> _listeners = [];
  String? _cancelReason;
  bool _isCancelled = false;

  void cancel([String? reason]) {
    if (_isCancelled) return;

    _isCancelled = true;
    _cancelReason = reason;

    for (final listener in _listeners) {
      listener(reason);
    }
    _listeners.clear();
  }

  bool get isCancelled => _isCancelled;

  void addCancelListener(void Function(String? reason) listener) {
    if (_isCancelled) {
      listener(_cancelReason);
      return;
    }

    _listeners.add(listener);
  }
}
