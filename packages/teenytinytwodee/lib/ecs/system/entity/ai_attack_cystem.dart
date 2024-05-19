import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/components/damage_component.dart';
import 'package:teenytinytwodee/ecs/components/inventory_component.dart';
import 'package:teenytinytwodee/ecs/components/properties/take_damage_component.dart';
import 'package:teenytinytwodee/ecs/components/sound/use_sound_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_entity_registry.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';

class AiAttackSystem implements GameSystem {
  final GameEntityRegistry _gameEntityRegistry = GameEntityRegistry();
  final AudioManager _audioManager = AudioManager();

  @override
  void processEntity(GameEntity gameEntity) {
    final GameEntity player = _gameEntityRegistry.getSingleton('player');

    final InventoryComponent inventory =
        gameEntity.getComponent('inventory')! as InventoryComponent;
    final GameEntity holdingItem = inventory.getCurrentItem()!;
    final DamageComponent damageComponent =
        holdingItem.getComponent('damage')! as DamageComponent;

    if (holdingItem.hasComponent('useSound')) {
      final UseSoundComponent useSound =
          holdingItem.getComponent('useSound')! as UseSoundComponent;
      _audioManager.play(useSound.soundName);
    }

    player.addComponent(TakeDamageComponent(damageComponent.amount));
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    gameEntity.removeComponent('attackAction');
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('ai') &&
        gameEntity.hasComponent('attackAction');
  }
}
