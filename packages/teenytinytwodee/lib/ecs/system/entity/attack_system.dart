import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/components/camera_component.dart';
import 'package:teenytinytwodee/ecs/components/damage_component.dart';
import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/components/inventory_component.dart';
import 'package:teenytinytwodee/ecs/components/properties/take_damage_component.dart';
import 'package:teenytinytwodee/ecs/components/sound/use_sound_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_entity_registry.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/rendering/rayCaster/camera.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';

class AttackSystem implements GameSystem {
  final WorldMap _worldMap = WorldMap();
  final GameEntityRegistry _gameEntityRegistry = GameEntityRegistry();
  final AudioManager _audioManager = AudioManager();

  @override
  void processEntity(GameEntity gameEntity) {
    final GameEntity player = _gameEntityRegistry.getSingleton('player');

    final CameraComponent cameraComponent =
        player.getComponent('camera')! as CameraComponent;

    final InventoryComponent inventory =
        player.getComponent('inventory')! as InventoryComponent;
    final GameEntity holdingItem = inventory.getCurrentItem()!;

    if (holdingItem.hasComponent('useSound')) {
      final UseSoundComponent useSound =
          holdingItem.getComponent('useSound')! as UseSoundComponent;
      _audioManager.play(useSound.soundName);
    }

    if (isNpc(cameraComponent.camera)) {
      attackNpc(cameraComponent.camera, holdingItem);
    }
  }

  bool isNpc(Camera camera) {
    final List<GameEntity> npcs = _worldMap.worldDefinition.npcs;

    if (npcs.isEmpty) {
      return false;
    }

    for (final GameEntity npc in npcs) {
      final DistanceComponent distanceComponent =
          npc.getComponent('distance')! as DistanceComponent;

      if (distanceComponent.distance <= 1) {
        return true;
      }
    }

    return false;
  }

  void attackNpc(Camera camera, GameEntity holdingItem) {
    final List<GameEntity> npcs = _worldMap.worldDefinition.npcs;

    for (final GameEntity npc in npcs) {
      final DistanceComponent distanceComponent =
          npc.getComponent('distance')! as DistanceComponent;

      if (distanceComponent.distance <= 1 && npc.hasComponent('health')) {
        final DamageComponent damageComponent =
            holdingItem.getComponent('damage')! as DamageComponent;

        npc.addComponent(TakeDamageComponent(damageComponent.amount));
        break;
      }
    }
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    gameEntity.removeComponent('attackAction');
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('attackAction') &&
        gameEntity.hasComponent('camera');
  }
}
