class EventBus {
  final Map<Type, List<Function>> _listeners = <Type, List<Function>>{};

  void publish<T>(T event) {
    try {
      if (_listeners.containsKey(T)) {
        _listeners[T]?.forEach((Function listener) => listener(event));
      }
    } on Exception catch (e) {
      print('Error publishing "$event": $e');

      rethrow;
    }
  }

  Function subscribe<T>(void Function(T) listener) {
    try {
      if (!_listeners.containsKey(T)) {
        _listeners[T] = <Function>[];
      }
      _listeners[T]?.add(listener);

      return listener;
    } on Exception catch (e) {
      print('Error subscribing to event: $e');

      rethrow;
    }
  }

  void unsubscribe<T>(Function listener) {
    try {
      if (_listeners.containsKey(T)) {
        _listeners[T]?.remove(listener);
      }
    } on Exception catch (e) {
      print('Error unsubscribing from event: $e');

      rethrow;
    }
  }
}
