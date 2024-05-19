import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class TimedSoundComponent implements GameComponent {
  TimedSoundComponent(
    this.soundName,
    this.soundFile,
    this.delay, {
    this.playThenRemove = true,
  }) : lastPlayed = DateTime.now().millisecondsSinceEpoch +
            getRandomBetween(1000, 10000) {
    _audioManager.register(soundName, soundFile);
  }

  bool playThenRemove;
  String soundFile;
  String soundName;
  int delay;
  int lastPlayed;
  final AudioManager _audioManager = AudioManager();

  @override
  String get name => 'timedSound';
}
