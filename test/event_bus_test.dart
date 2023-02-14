// ignore_for_file: cascade_invocations

import 'package:test/test.dart';

import 'package:dart_event_bus/event_bus.dart';

void main() {
  group('event bus test =>', () {
    late EventBus eventBus;

    setUp(() => eventBus = EventBus());

    test('should publish events to subscribed listeners.', () {
      final List<int> events = <int>[];

      eventBus.subscribe<int>((int event) => events.add(event));
      eventBus.publish(1);
      eventBus.publish(2);

      expect(events, <int>[1, 2]);
    });

    test('should unsubscribe listeners.', () {
      final List<int> events = <int>[];
      final Function listener =
          eventBus.subscribe<int>((int event) => events.add(event));

      eventBus.publish(1);
      eventBus.unsubscribe<int>(listener);
      eventBus.publish(2);

      expect(events, <int>[1]);
    });

    test('should not publish events to unsubscribed listeners.', () {
      final List<int> events = <int>[];
      final Function listener =
          eventBus.subscribe<int>((int event) => events.add(event));

      eventBus.unsubscribe<int>(listener);
      eventBus.publish(1);

      expect(events, <int>[]);
    });

    test('should publish events to subscribed listeners of different types.',
        () {
      final List<int> intEvents = <int>[];
      final List<String> stringEvents = <String>[];

      eventBus.subscribe<int>((int event) => intEvents.add(event));
      eventBus.subscribe<String>((String event) => stringEvents.add(event));

      eventBus.publish(1);
      eventBus.publish('hello');
      eventBus.publish(2);
      eventBus.publish('world');

      expect(intEvents, <int>[1, 2]);
      expect(stringEvents, <String>['hello', 'world']);
    });

    test('should not deliver events to listeners subscribed to other types.',
        () {
      final List<int> intEvents = <int>[];
      final List<String> stringEvents = <String>[];

      eventBus.subscribe<int>((int event) => intEvents.add(event));
      eventBus.subscribe<String>((String event) => stringEvents.add(event));

      eventBus.publish(true);
      eventBus.publish(3.14);

      expect(intEvents, <int>[]);
      expect(stringEvents, <String>[]);
    });

    test('should deliver events to all subscribed listeners of the same type.',
        () {
      final List<int> events1 = <int>[];
      final List<int> events2 = <int>[];

      final Function listener1 =
          eventBus.subscribe<int>((int event) => events1.add(event));
      final Function listener2 =
          eventBus.subscribe<int>((int event) => events2.add(event));

      eventBus.publish(1);
      eventBus.publish(2);

      expect(events1, <int>[1, 2]);
      expect(events2, <int>[1, 2]);

      eventBus.unsubscribe<int>(listener1);
      eventBus.publish(3);

      expect(events1, <int>[1, 2]);
      expect(events2, <int>[1, 2, 3]);

      eventBus.unsubscribe<int>(listener2);
      eventBus.publish(4);

      expect(events1, <int>[1, 2]);
      expect(events2, <int>[1, 2, 3]);
    });
  });
}
