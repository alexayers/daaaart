import 'package:teenytinytwodee/ecs/game_component.dart';

class VelocityComponent implements GameComponent {
  VelocityComponent(int valueX, int valueY)
      : velX = valueX,
        velY = valueY;
  num velX;
  num velY;
  bool rotateRight = false;
  bool rotateLeft = false;

  @override
  String get name => 'velocity';
}
