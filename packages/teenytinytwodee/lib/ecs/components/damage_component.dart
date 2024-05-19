import 'package:teenytinytwodee/ecs/game_component.dart';

class DamageComponent implements GameComponent {
  DamageComponent(this.amount);
  int amount;

  @override
  String get name => 'damage';
}
