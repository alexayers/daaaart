import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/rendering/rayCaster/camera.dart';

class CameraComponent implements GameComponent {
  CameraComponent(this.camera);
  Camera camera;

  @override
  String get name => 'camera';
}
