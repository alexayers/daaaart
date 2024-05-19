import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/spritesheet.dart';

class SpriteSheetComponent implements GameComponent {
  SpriteSheetComponent(this.spriteSheet, this.spriteName);

  SpriteSheet spriteSheet;
  String spriteName;

  @override
  String get name => 'spriteSheet';
}
