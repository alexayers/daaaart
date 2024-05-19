import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';

class GameEntityRegistry {
  factory GameEntityRegistry() {
    return _instance;
  }

  GameEntityRegistry._privateConstructor();
  static final GameEntityRegistry _instance =
      GameEntityRegistry._privateConstructor();

  final List<GameEntity> _entities = [];
  final Map<String, GameEntity> _singletonEntities = {};

  void register(GameEntity gameEntity) {
    gameEntity.addComponent(DistanceComponent(1));
    _entities.add(gameEntity);
  }

  void registerSingleton(GameEntity gameEntity) {
    _singletonEntities[gameEntity.name] = gameEntity;
  }

  GameEntity getSingleton(String name) {
    return _singletonEntities[name]!;
  }

  List<GameEntity> getEntities() {
    return _entities;
  }
}
