import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/animated_sprite.dart';

class AnimatedSpriteComponent implements GameComponent {
  AnimatedSpriteComponent(
    Map<String, List<String>> imageFiles,
    String currentAction,
  ) : animatedSprite = AnimatedSprite(
          imageFiles: imageFiles,
          currentAction: currentAction,
        );

  AnimatedSprite animatedSprite;

  @override
  String get name => 'animatedSprite';
}
