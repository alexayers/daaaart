import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class CanDamageComponent implements GameComponent {
  CanDamageComponent(this.sprite);
  Sprite sprite;

  @override
  String get name => 'canDamage';
}
