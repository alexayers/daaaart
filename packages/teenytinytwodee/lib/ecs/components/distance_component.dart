import 'package:teenytinytwodee/ecs/game_component.dart';

class DistanceComponent implements GameComponent {
  DistanceComponent([num value = 0]) : distance = value;
  num distance;

  @override
  String get name => 'distance';
}
