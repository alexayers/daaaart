import 'package:teenytinytwodee/ecs/components/position_component.dart';
import 'package:teenytinytwodee/ecs/components/rendering/animated_sprite_component.dart';
import 'package:teenytinytwodee/ecs/components/velocity_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_system.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';

enum MovementDirection { up, down, left, right }

class MovementSystem implements GameSystem {
  final WorldMap _worldMap = WorldMap();

  @override
  void processEntity(GameEntity gameEntity) {
    final VelocityComponent velocityComponent =
        gameEntity.getComponent('velocity')! as VelocityComponent;
    final PositionComponent positionComponent =
        gameEntity.getComponent('position')! as PositionComponent;

    final int tempX = (positionComponent.x + velocityComponent.velX).floor();
    final int tempY = (positionComponent.y + velocityComponent.velY).floor();

    MovementDirection movementDirection = MovementDirection.right;

    if (velocityComponent.velX > 0) {
      movementDirection = MovementDirection.right;
    } else if (velocityComponent.velX < 0) {
      movementDirection = MovementDirection.left;
    } else if (velocityComponent.velY > 0) {
      movementDirection = MovementDirection.up;
    } else if (velocityComponent.velY > 0) {
      movementDirection = MovementDirection.down;
    }

    final AnimatedSpriteComponent animatedSpriteComponent =
        gameEntity.getComponent('animatedSprite')! as AnimatedSpriteComponent;

    //logger(logType, msg)

    if (tempX > positionComponent.x) {
      //  logger(LogType.info, "moving...");
    } else if (tempX < positionComponent.x) {
      //  logger(LogType.info, "moving...");
    } else if (tempY > positionComponent.y) {
      //   logger(LogType.info, "moving...");
    } else if (tempY < positionComponent.y) {
      //logger(LogType.info, "moving...");
    }

    if (canWalk(tempX, tempY, movementDirection)) {
      positionComponent.x += velocityComponent.velX;
      positionComponent.y += velocityComponent.velY;
      animatedSpriteComponent.animatedSprite.currentAction = 'walking';
    } else {
      animatedSpriteComponent.animatedSprite.currentAction = 'default';
    }

    velocityComponent.velX = 0;
    velocityComponent.velY = 0;
  }

  bool canWalk(int x, int y, MovementDirection movementDirection) {
    final int checkMapX = x;
    final int checkMapY = y;

    final GameEntity gameEntity =
        _worldMap.getEntityAtPosition(checkMapX, checkMapY);

    if (gameEntity.hasComponent('wall')) {
      return false;
    }

    return true;
  }

  @override
  void removeIfPresent(GameEntity gameEntity) {}

  @override
  bool shouldRun(GameEntity gameEntity) {
    return gameEntity.hasComponent('velocity') &&
        gameEntity.hasComponent('position') &&
        !gameEntity.hasComponent('dead');
  }
}
