import 'package:teenytinytwodee/ecs/game_component.dart';

enum MovementStyle { wander, follow }

class AiComponent implements GameComponent {
  AiComponent(this.movementStyle, this.friend);

  MovementStyle movementStyle;
  int ticksSinceLastChange = 0;
  int currentDirection = 1;
  int attackCoolDown = 0;
  bool friend;

  @override
  String get name => 'ai';
}
