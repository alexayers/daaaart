import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/spritesheet.dart';

class AnimatedSpriteSheetComponent implements GameComponent {
  AnimatedSpriteSheetComponent(
    this.spriteSheet,
    this.animation,
    this.currentAction,
  );

  SpriteSheet spriteSheet;
  Map<String, List<String>> animation;
  String currentAction;

  @override
  String get name => 'animatedSpriteSheet';
}
