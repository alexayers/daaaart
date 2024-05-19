import 'package:teenytinytwodee/ecs/game_component.dart';

class PushWallComponent implements GameComponent {
  bool _openWall = false;

  void openWall() {
    _openWall = true;
  }

  bool isWallOpen() {
    return _openWall;
  }

  @override
  String get name => 'pushWall';
}
