class EventBus {
  final Map<Type, List<Function>> _listeners = <Type, List<Function>>{};

  void publish<T>(T event) {
    if (_listeners.containsKey(T)) {
      _listeners[T]?.forEach((Function listener) => listener(event));
    }
  }

  Function subscribe<T>(void Function(T) listener) {
    if (!_listeners.containsKey(T)) {
      _listeners[T] = <Function>[];
    }
    _listeners[T]?.add(listener);
    return listener;
  }

  void unsubscribe<T>(Function listener) {
    if (_listeners.containsKey(T)) {
      _listeners[T]?.remove(listener);
    }
  }
}
