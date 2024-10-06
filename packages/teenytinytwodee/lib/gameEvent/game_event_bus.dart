import 'package:teenytinytwodee/gameEvent/game_event.dart';
import 'package:teenytinytwodee/logger/logger.dart';

class GameEventBus {
  factory GameEventBus() {
    return _instance;
  }

  GameEventBus._privateConstructor();

  final _logger = Logger();
  static final GameEventBus _instance = GameEventBus._privateConstructor();
  final Map<String, List<void Function(GameEvent gameEvent)>> _channels = {};

  void register(
    String channel,
    void Function(GameEvent gameEvent) eventHandler,
  ) {
    if (!_channels.containsKey(channel)) {
      _logger.info('Creating new channel -> $channel');
      _channels[channel] = [];
    }

    _channels[channel]?.add(eventHandler);
  }

  void publish(GameEvent gameEvent) {
    if (_channels.containsKey(gameEvent.channel)) {
      final List<void Function(GameEvent gameEvent)>? listeners =
          _channels[gameEvent.channel];

      for (final listener in listeners!) {
        try {
          listener(gameEvent);
        } catch (e) {
          _logger.error(e.toString());
        }
      }
    } else {
      throw Exception('No listeners for channel ${gameEvent.channel}');
    }
  }
}
