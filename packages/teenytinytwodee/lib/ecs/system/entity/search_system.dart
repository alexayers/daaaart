import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';

class SearchSystem implements GameSystem {
  @override
  void processEntity(GameEntity gameEntity) {
    // TODO: implement processEntity
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    // TODO: implement removeIfPresent
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return false;
  }
}
