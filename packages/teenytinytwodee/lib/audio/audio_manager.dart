import 'package:teenytinytwodee/audio/audio_file.dart';
import 'package:teenytinytwodee/gameEvent/game_event.dart';
import 'package:teenytinytwodee/logger/logger.dart';

class AudioManager {
  factory AudioManager() {
    return _instance;
  }

  AudioManager._privateConstructor();
  static final AudioManager _instance = AudioManager._privateConstructor();
  final bool _audioEnabled = true;
  final Map<String, AudioFile> _soundMap = {};
  final _logger = Logger();

  void register(String name, String audioFile, [bool loop = false]) {
    _soundMap[name] = AudioFile(audioFile, loop);
    _logger.info('Registered sound: $name');
  }

  void play(String name) {
    if (_audioEnabled) {
      try {
        _soundMap[name]?.play();
      } catch (e) {
        _logger.error('Error playing sound: $name');
      }
    }
  }

  void stop(String name) {
    if (_audioEnabled) {
      try {
        _soundMap[name]?.stop();
      } catch (e) {
        _logger.error('Error stopping sound: $name');
      }
    }
  }

  void handleEvent(GameEvent gameEvent) {
    play(gameEvent.payload as String);
  }
}
