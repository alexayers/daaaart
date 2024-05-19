import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class HoldingSpriteComponent implements GameComponent {
  HoldingSpriteComponent(this.sprite);
  Sprite sprite;

  @override
  String get name => 'holdingSprite';
}
