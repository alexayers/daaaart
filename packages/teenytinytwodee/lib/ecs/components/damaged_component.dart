import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class DamagedComponent implements GameComponent {
  DamagedComponent(this.damage, this.damageSprite);
  int damage;
  Sprite damageSprite;

  @override
  String get name => 'damaged';
}
