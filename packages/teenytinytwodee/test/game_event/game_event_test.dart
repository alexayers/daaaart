import 'package:teenytinytwodee/gameEvent/game_event.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:test/test.dart';

void main() {
  group('GameEventBus', () {
    test('register and publish', () {
      final bus = GameEventBus();

      // Register a listener for a channel
      bus.register('channel1', (gameEvent) {
        // Assert that the gameEvent is received correctly
        expect(gameEvent.channel, 'channel1');
        expect(gameEvent.payload, 'Test data');
      });

      // Publish a game event
      bus.publish(GameEvent('channel1', 'Test data'));
    });

    test('publish with no listeners', () {
      final bus = GameEventBus();

      expect(
        () => bus.publish(GameEvent('channel2', 'Test data')),
        throwsA(isA<Exception>()),
      );
    });
  });
}
