// ignore_for_file: cascade_invocations

import 'package:dart_event_bus/event_bus.dart';

void main(List<String> args) {
  final EventBus bus = EventBus();

  final Function stringListener = bus.subscribe<String>(
    (String event) => print('Received string event: $event'),
  );

  final Function intListener =
      bus.subscribe<int>((int event) => print('Received int event: $event'));

  bus.publish('Hello, world!');
  bus.publish(10);

  bus.unsubscribe<String>(stringListener);
  bus.unsubscribe<int>(intListener);

  bus.publish('Hello, world!');
  bus.publish(10);
}
