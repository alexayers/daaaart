import 'dart:math';

import 'package:teenytinytwodee/ecs/components/door_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class Camera {
  Camera(this.xPos, this.yPos, this.xDir, this.yDir, this.fov) {
    xPlane = rotateVector(xDir, yDir, -pi / 2).x * fov;
    yPlane = rotateVector(xDir, yDir, -pi / 2).y * fov;
  }
  num xPos;
  num yPos;
  num xDir;
  num yDir;
  num fov;
  late num xPlane;
  late num yPlane;
  final WorldMap _worldMap = WorldMap();

  void move(num moveX, num moveY) {
    GameEntity gameEntity =
        _worldMap.getEntityAtPosition((xPos + moveX).floor(), yPos.floor());

    if (npcPresent()) {
      return;
    }

    if (gameEntity.hasComponent('floor') ||
        gameEntity.hasComponent('transparent')) {
      xPos += moveX;
    }

    if (gameEntity.hasComponent('door')) {
      final DoorComponent door =
          gameEntity.getComponent('door')! as DoorComponent;

      if (door.isOpen()) {
        xPos += moveX;
      }
    }

    gameEntity =
        _worldMap.getEntityAtPosition(xPos.floor(), (yPos + moveY).floor());

    if (gameEntity.hasComponent('floor') ||
        gameEntity.hasComponent('transparent')) {
      yPos += moveY;
    }

    if (gameEntity.hasComponent('door')) {
      final DoorComponent door =
          gameEntity.getComponent('door')! as DoorComponent;

      if (door.isOpen()) {
        yPos += moveY;
      }
    }
  }

  void rotate(num angle) {
    final Point rDir = rotateVector(xDir, yDir, angle);
    xDir = rDir.x;
    yDir = rDir.y;

    final Point rPlane = rotateVector(xPlane, yPlane, angle);
    xPlane = rPlane.x;
    yPlane = rPlane.y;
  }

  Vector2 get position => Vector2(xPos, yPos);
  Vector2 get direction => Vector2(xDir, yDir);

  bool npcPresent() {
    const bool npcInTheWay = false;

    return npcInTheWay;
  }
}
