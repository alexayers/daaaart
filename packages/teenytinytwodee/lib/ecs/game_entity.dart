import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:uuid/uuid.dart';

class GameEntity {
  GameEntity(String name)
      : _id = const Uuid().v4(),
        _name = name;
  final String _id;
  final String _name;
  final Map<String, GameComponent> _gameComponents = {};

  void addComponent(GameComponent gameComponent) {
    _gameComponents[gameComponent.name] = gameComponent;
  }

  GameComponent? getComponent(String name) {
    return _gameComponents[name];
  }

  void removeComponent(String name) {
    _gameComponents.remove(name);
  }

  bool hasComponent(String name) {
    return _gameComponents.containsKey(name);
  }

  Map<String, GameComponent> get gameComponents => _gameComponents;

  String get name => _name;

  String get id => _id;
}
