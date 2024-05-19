import 'package:teenytinytwodee/ecs/game_component.dart';

class HealthComponent implements GameComponent {
  HealthComponent(this.current, this.max);
  int current;
  int max;

  @override
  String get name => 'health';
}
