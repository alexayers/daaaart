import 'package:teenytinytwodee/ecs/components/camera_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_entity_registry.dart';
import 'package:teenytinytwodee/ecs/game_render_system.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/rayCaster/raycaster.dart';
import 'package:teenytinytwodee/rendering/rayCaster/render_performance.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class RayCastRenderSystem implements GameRenderSystem {
  final RayCaster _rayCaster = RayCaster();
  final WorldMap _worldMap = WorldMap();
  final Renderer _renderer = Renderer();
  final GameEntityRegistry _gameEntityRegistry = GameEntityRegistry();
  final RenderPerformance _renderPerformance = RenderPerformance();

  @override
  void process() {
    final GameEntity player = _gameEntityRegistry.getSingleton('player');
    _renderPerformance.updateFrameTimes();
    _worldMap.moveDoors();

    final CameraComponent camera =
        player.getComponent('camera')! as CameraComponent;

    _rayCaster.drawSkyBox(
      Color(red: 74, green: 67, blue: 57),
      Color(red: 40, green: 40, blue: 40),
    );

    for (int x = 0; x < _renderer.getCanvasWidth(); x++) {
      _rayCaster.drawWall(camera.camera, x);
    }

    _rayCaster.drawSpritesAndTransparentWalls(camera.camera);
    _rayCaster.flushBuffer();
  }
}
