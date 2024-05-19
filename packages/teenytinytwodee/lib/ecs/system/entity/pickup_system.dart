import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/components/inventory_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';

class PickUpSystem implements GameSystem {
  final WorldMap _worldMap = WorldMap();

  @override
  void processEntity(GameEntity gameEntity) {
    final InventoryComponent inventory =
        gameEntity.getComponent('inventory')! as InventoryComponent;

    final List<GameEntity> gameEntities = _worldMap.getWorldItems();

    for (int i = 0; i < gameEntities.length; i++) {
      final GameEntity gameEntity = gameEntities[i];
      final DistanceComponent distance =
          gameEntity.getComponent('distance')! as DistanceComponent;

      if (distance.distance < 1) {
        _worldMap.removeWorldItem(gameEntity);
        inventory.addItem(gameEntity);
      }
    }
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    gameEntity.removeComponent('pickUp');
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('pickUp');
  }
}
