import 'package:teenytinytwodee/ecs/components/camera_component.dart';
import 'package:teenytinytwodee/ecs/components/velocity_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/rendering/rayCaster/render_performance.dart';

class CameraSystem implements GameSystem {
  final double _turnSpeed = 0.038;
  final RenderPerformance _renderPerformance = RenderPerformance();

  @override
  void processEntity(GameEntity gameEntity) {
    final double turnSpeed = _turnSpeed * _renderPerformance.deltaTime;

    final CameraComponent camera =
        gameEntity.getComponent('camera')! as CameraComponent;
    final VelocityComponent velocity =
        gameEntity.getComponent('velocity')! as VelocityComponent;

    camera.camera.move(velocity.velX, velocity.velY);

    if (velocity.rotateRight) {
      camera.camera.rotate(-turnSpeed);
    }

    if (velocity.rotateLeft) {
      camera.camera.rotate(turnSpeed);
    }

    velocity.velX = 0;
    velocity.velY = 0;
    velocity.rotateLeft = false;
    velocity.rotateRight = false;
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {
    // TODO: implement removeIfPresent
  }

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('camera');
  }
}
