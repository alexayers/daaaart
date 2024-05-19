import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class InventorySpriteComponent implements GameComponent {
  InventorySpriteComponent(this.sprite);
  Sprite sprite;

  @override
  String get name => 'inventorySprite';
}
