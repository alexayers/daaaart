import 'package:teenytinytwodee/audio/audio_file.dart';
import 'package:teenytinytwodee/gameEvent/game_event.dart';

class AudioManager {
  factory AudioManager() {
    return _instance;
  }

  AudioManager._privateConstructor();
  static final AudioManager _instance = AudioManager._privateConstructor();
  final bool _audioEnabled = true;
  final Map<String, AudioFile> _soundMap = {};

  void register(String name, String audioFile, [bool loop = false]) {
    _soundMap[name] = AudioFile(audioFile, loop);
  }

  void play(String name) {
    if (_audioEnabled) {
      _soundMap[name]?.play();
    }
  }

  void stop(String name) {
    if (_audioEnabled) {
      _soundMap[name]?.stop();
    }
  }

  void handleEvent(GameEvent gameEvent) {
    play(gameEvent.payload as String);
  }
}
