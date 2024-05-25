import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/components/attributes/health_component.dart';
import 'package:teenytinytwodee/ecs/components/dead_component.dart';
import 'package:teenytinytwodee/ecs/components/properties/take_damage_component.dart';
import 'package:teenytinytwodee/ecs/components/rendering/animated_sprite_component.dart';
import 'package:teenytinytwodee/ecs/components/sound/hurt_sound_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/logger/logger.dart';

class DamageSystem implements GameSystem {
  AudioManager audioManager = AudioManager();
  final Logger _logger = Logger();

  @override
  void processEntity(GameEntity gameEntity) {
    final HealthComponent healthComponent =
        gameEntity.getComponent('health')! as HealthComponent;
    final TakeDamageComponent takeDamageComponent =
        gameEntity.getComponent('takeDamage')! as TakeDamageComponent;

    healthComponent.current -= takeDamageComponent.damage;

    if (healthComponent.current <= 0) {
      healthComponent.current = 0;
      gameEntity.addComponent(DeadComponent());

      if (!gameEntity.hasComponent('camera')) {
        gameEntity.removeComponent('ai');
        gameEntity.removeComponent('health');
        final AnimatedSpriteComponent animatedSpriteComponent = gameEntity
            .getComponent('animatedSprite')! as AnimatedSpriteComponent;
        animatedSpriteComponent.animatedSprite.currentAction = 'dead';

        _logger.debug('${gameEntity.name} is dead.');
      }
    } else {
      if (gameEntity.hasComponent('hurtSound')) {
        final HurtSoundComponent hurtSoundComponent =
            gameEntity.getComponent('hurtSound')! as HurtSoundComponent;
        audioManager.play(hurtSoundComponent.soundName);
      }
    }
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    gameEntity.removeComponent('takeDamage');
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('takeDamage') &&
        gameEntity.hasComponent('health');
  }
}
