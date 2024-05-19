import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';

class GameEntityBuilder {
  GameEntityBuilder(String name) : _gameEntity = GameEntity(name) {
    _gameEntity.addComponent(DistanceComponent());
  }
  final GameEntity _gameEntity;

  GameEntityBuilder addComponent(GameComponent gameComponent) {
    _gameEntity.addComponent(gameComponent);
    return this;
  }

  GameEntity build() {
    return _gameEntity;
  }
}
