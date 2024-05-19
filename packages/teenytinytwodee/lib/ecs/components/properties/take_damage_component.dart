import 'package:teenytinytwodee/ecs/game_component.dart';

class TakeDamageComponent implements GameComponent {
  TakeDamageComponent(this.damage);

  int damage;

  @override
  String get name => 'takeDamage';
}
