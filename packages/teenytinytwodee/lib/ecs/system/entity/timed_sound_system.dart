import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/components/sound/timed_sound_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class TimedSoundSystem implements GameSystem {
  final AudioManager _audioManager = AudioManager();

  @override
  void processEntity(GameEntity gameEntity) {
    final TimedSoundComponent timedSoundComponent =
        gameEntity.getComponent('timedSound')! as TimedSoundComponent;

    if (timedSoundComponent.lastPlayed + timedSoundComponent.delay <
        DateTime.now().millisecondsSinceEpoch) {
      timedSoundComponent.lastPlayed =
          DateTime.now().millisecondsSinceEpoch + getRandomBetween(9000, 20000);
      _audioManager.play(timedSoundComponent.soundName);
    }
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {}

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('timedSound');
  }
}
