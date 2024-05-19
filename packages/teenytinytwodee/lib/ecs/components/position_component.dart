import 'package:teenytinytwodee/ecs/game_component.dart';

class PositionComponent implements GameComponent {
  PositionComponent(num valueX, num valueY)
      : x = valueX,
        y = valueY;
  num x;
  num y;

  @override
  String get name => 'position';
}
