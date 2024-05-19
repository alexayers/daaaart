import 'package:teenytinytwodee/ecs/components/ai/ai_component.dart';
import 'package:teenytinytwodee/ecs/components/camera_component.dart';
import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/components/interactions/attack_action_component.dart';
import 'package:teenytinytwodee/ecs/components/position_component.dart';
import 'package:teenytinytwodee/ecs/components/velocity_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_entity_registry.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/pathFinding/a_star.dart';
import 'package:teenytinytwodee/rendering/rayCaster/camera.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class AiSystem implements GameSystem {
  final GameEntityRegistry _gameEntityRegistry = GameEntityRegistry();

  @override
  void processEntity(GameEntity gameEntity) {
    final GameEntity player = _gameEntityRegistry.getSingleton('player');
    final PositionComponent positionComponent =
        gameEntity.getComponent('position')! as PositionComponent;
    final VelocityComponent velocityComponent =
        gameEntity.getComponent('velocity')! as VelocityComponent;
    final AiComponent aiComponent =
        gameEntity.getComponent('ai')! as AiComponent;

    switch (aiComponent.movementStyle) {
      case MovementStyle.wander:
        wander(aiComponent, velocityComponent);
      case MovementStyle.follow:
        follow(velocityComponent, positionComponent, player);
    }

    if (!aiComponent.friend) {
      final DistanceComponent distanceComponent =
          gameEntity.getComponent('distance')! as DistanceComponent;

      if (distanceComponent.distance <= 2 &&
          DateTime.now().millisecondsSinceEpoch >= aiComponent.attackCoolDown) {
        gameEntity.addComponent(AttackActionComponent());
        aiComponent.attackCoolDown =
            DateTime.now().millisecondsSinceEpoch + 1000;
      }
    }
  }

  void follow(
    VelocityComponent velocityComponent,
    PositionComponent positionComponent,
    GameEntity player,
  ) {
    final CameraComponent cameraComponent =
        player.getComponent('camera')! as CameraComponent;
    final Camera camera = cameraComponent.camera;

    final AStar aStar = AStar(
      positionComponent.x.floor(),
      positionComponent.y.floor(),
      camera.xPos.floor(),
      camera.yPos.floor(),
    );

    if (aStar.isPathFound()) {
      final List<PathNode> pathNodes = aStar.path;

      if (pathNodes.isEmpty) {
        return;
      }

      try {
        if (pathNodes[0].x > positionComponent.x.floor()) {
          velocityComponent.velX = 0.02;
        } else if (pathNodes[0].x < positionComponent.x.floor()) {
          velocityComponent.velX = -0.02;
        }

        if (pathNodes[0].y > positionComponent.y.floor()) {
          velocityComponent.velY = 0.02;
        } else if (pathNodes[0].y < positionComponent.y.floor()) {
          velocityComponent.velY = -0.02;
        }
      } catch (e) {
        logger(LogType.error, e.toString());
      }
    } else {
      logger(LogType.info, 'oh noes');
    }
  }

  void wander(AiComponent aiComponent, VelocityComponent velocityComponent) {
    aiComponent.ticksSinceLastChange++;

    if (aiComponent.ticksSinceLastChange == 100) {
      aiComponent.ticksSinceLastChange = 0;
      aiComponent.currentDirection = getRandomBetween(1, 4);
    }

    switch (aiComponent.currentDirection) {
      case 1:
        velocityComponent.velX = 0.02;
      case 2:
        velocityComponent.velX = -0.02;
      case 3:
        velocityComponent.velY = 0.02;
      case 4:
        velocityComponent.velY = -0.02;
    }
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {}

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('ai');
  }
}
