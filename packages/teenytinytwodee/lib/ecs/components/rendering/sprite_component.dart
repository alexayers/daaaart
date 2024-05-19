import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class SpriteComponent implements GameComponent {
  SpriteComponent(Sprite value) : sprite = value;
  Sprite sprite;

  @override
  String get name => 'sprite';
}
