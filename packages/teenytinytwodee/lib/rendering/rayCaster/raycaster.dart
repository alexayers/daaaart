import 'dart:html';
import 'dart:math' as math;
import 'dart:math';

import 'package:teenytinytwodee/ecs/components/camera_component.dart';
import 'package:teenytinytwodee/ecs/components/distance_component.dart';
import 'package:teenytinytwodee/ecs/components/position_component.dart';
import 'package:teenytinytwodee/ecs/components/rendering/animated_sprite_component.dart';
import 'package:teenytinytwodee/ecs/components/rendering/sprite_component.dart';
import 'package:teenytinytwodee/ecs/components/rendering/spritesheet_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/ecs/game_entity_registry.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/rayCaster/camera.dart';
import 'package:teenytinytwodee/rendering/rayCaster/transparent_wall.dart';
import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class RayCaster {
  RayCaster() {
    for (int x = 0; x < _renderer.getCanvasWidth(); x++) {
      final double cameraX = 2 * x / _renderer.getCanvasWidth() - 1;
      _cameraXCoords.add(cameraX);
    }
  }

  final Renderer _renderer = Renderer();
  final List<num> _cameraXCoords = [];
  final List<num> _zBuffer = List.filled(1024, 0.0);
  final List<TransparentWall> _transparentWalls = [];
  final WorldMap worldMap = WorldMap();
  final GameEntityRegistry _gameEntityRegistry = GameEntityRegistry();

  void drawWall(Camera camera, int x) {
    final num rayDirX = camera.xDir + camera.xPlane * _cameraXCoords[x];
    final num rayDirY = camera.yDir + camera.yPlane * _cameraXCoords[x];
    int mapX = camera.xPos.floor();
    int mapY = camera.yPos.floor();
    num sideDistX;
    num sideDistY;
    final num deltaDistX = (1 / rayDirX).abs();
    final num deltaDistY = (1 / rayDirY).abs();
    num perpWallDist = 0;
    int stepX;
    int stepY;
    int hit = 0;
    int side = 0;
    num wallXOffset = 0;
    num wallYOffset = 0;
    num wallX = 0;
    int rayTex = 0;
    GameEntity? gameEntity;

    if (rayDirX < 0) {
      stepX = -1;
      sideDistX = (camera.xPos - mapX) * deltaDistX;
    } else {
      stepX = 1;
      sideDistX = (mapX + 1.0 - camera.xPos) * deltaDistX;
    }

    if (rayDirY < 0) {
      stepY = -1;
      sideDistY = (camera.yPos - mapY) * deltaDistY;
    } else {
      stepY = 1;
      sideDistY = (mapY + 1.0 - camera.yPos) * deltaDistY;
    }

    while (hit == 0) {
      if (sideDistX < sideDistY) {
        sideDistX += deltaDistX;
        mapX += stepX;
        side = 0;
      } else {
        sideDistY += deltaDistY;
        mapY += stepY;
        side = 1;
      }

      gameEntity = worldMap.getEntityAtPosition(mapX, mapY);

      if (!gameEntity.hasComponent('floor')) {
        if (gameEntity.hasComponent('door') &&
            worldMap.getDoorState(mapX, mapY) != DoorState.open) {
          hit = 1;
          if (side == 1) {
            wallYOffset = 0.5 * stepY;
            perpWallDist =
                (mapY - camera.yPos + wallYOffset + (1 - stepY) / 2) / rayDirY;
            wallX = camera.xPos + perpWallDist * rayDirX;
            wallX -= wallX.floor();
            if (sideDistY - (deltaDistY / 2) < sideDistX) {
              if (1.0 - wallX <= worldMap.getDoorOffset(mapX, mapY)) {
                hit = 0;
                wallYOffset = 0;
              }
            } else {
              mapX += stepX;
              side = 0;
              rayTex = 4;
              wallYOffset = 0;
            }
          } else {
            wallXOffset = 0.5 * stepX;
            perpWallDist =
                (mapX - camera.xPos + wallXOffset + (1 - stepX) / 2) / rayDirX;
            wallX = camera.yPos + perpWallDist * rayDirY;
            wallX -= wallX.floor();
            if (sideDistX - (deltaDistX / 2) < sideDistY) {
              if (1.0 - wallX < worldMap.getDoorOffset(mapX, mapY)) {
                hit = 0;
                wallXOffset = 0;
              }
            } else {
              mapY += stepY;
              side = 1;
              rayTex = 4;
              wallXOffset = 0;
            }
          }
        } else if (gameEntity.hasComponent('pushWall') &&
            worldMap.getDoorState(mapX, mapY) != DoorState.open) {
          if (side == 1 &&
              sideDistY -
                      (deltaDistY * (1 - worldMap.getDoorOffset(mapX, mapY))) <
                  sideDistX) {
            hit = 1;
            wallYOffset = worldMap.getDoorOffset(mapX, mapY) * stepY;
          } else if (side == 0 &&
              sideDistX -
                      (deltaDistX * (1 - worldMap.getDoorOffset(mapX, mapY))) <
                  sideDistY) {
            hit = 1;
            wallXOffset = worldMap.getDoorOffset(mapX, mapY) * stepX;
          }
        } else if (gameEntity.hasComponent('transparent')) {
          if (side == 1) {
            if (sideDistY - (deltaDistY / 2) < sideDistX) {
              bool wallDefined = false;
              for (int i = 0; i < _transparentWalls.length; i++) {
                if (_transparentWalls[i].xMap == mapX &&
                    _transparentWalls[i].yMap == mapY) {
                  _transparentWalls[i].cameraXCoords.add(x);
                  wallDefined = true;
                  break;
                }
              }
              if (!wallDefined) {
                final SpriteComponent sprite =
                    gameEntity.getComponent('sprite')! as SpriteComponent;
                final TransparentWall transparentWall = TransparentWall(
                  sprite.sprite,
                  camera,
                  mapX,
                  mapY,
                  side,
                  x,
                  _cameraXCoords,
                );
                _transparentWalls.add(transparentWall);
              }
            }
          } else {
            if (sideDistX - (deltaDistX / 2) < sideDistY) {
              bool wallDefined = false;
              for (int i = 0; i < _transparentWalls.length; i++) {
                if (_transparentWalls[i].xMap == mapX &&
                    _transparentWalls[i].yMap == mapY) {
                  _transparentWalls[i].cameraXCoords.add(x);
                  wallDefined = true;
                  break;
                }
              }
              if (!wallDefined) {
                final SpriteComponent sprite =
                    gameEntity.getComponent('sprite')! as SpriteComponent;
                final TransparentWall transparentWall = TransparentWall(
                  sprite.sprite,
                  camera,
                  mapX,
                  mapY,
                  side,
                  x,
                  _cameraXCoords,
                );
                _transparentWalls.add(transparentWall);
              }
            }
          }
        } else if (!gameEntity.hasComponent('door') &&
            !gameEntity.hasComponent('pushWall')) {
          final GameEntity adjacentGameEntityUp =
              worldMap.getEntityAtPosition(mapX, mapY - stepY);
          final GameEntity adjacentGameEntityAcross =
              worldMap.getEntityAtPosition(mapX - stepX, mapY);

          if (side == 1 && adjacentGameEntityUp.hasComponent('door')) {
            rayTex = 4;
          } else if (side == 0 &&
              adjacentGameEntityAcross.hasComponent('door')) {
            rayTex = 4;
          }

          hit = 1;
        }
      }
    }

    perpWallDist = calculatePerpWall(
      side,
      mapX,
      mapY,
      camera,
      wallXOffset,
      wallYOffset,
      stepX,
      stepY,
      rayDirX,
      rayDirY,
    );

    _zBuffer[x] = perpWallDist;

    final int lineHeight = (_renderer.getCanvasHeight() / perpWallDist).round();
    final double drawStart =
        -lineHeight / 2 + (_renderer.getCanvasHeight() / 2).round();

    if (side == 0) {
      wallX = camera.yPos + perpWallDist * rayDirY;
    } else if (side == 1 || side == 2) {
      wallX = camera.xPos + perpWallDist * rayDirX;
    }

    wallX -= wallX.floor();

    if (gameEntity!.hasComponent('door')) {
      wallX += worldMap.getDoorOffset(mapX, mapY);
    }

    // Swap texture out for door frame
    if (rayTex == 4) {
      gameEntity = GameEntityRegistry().getSingleton('doorFrame');
    }

    renderWall(
      gameEntity,
      wallX,
      side,
      rayDirX,
      rayDirY,
      drawStart,
      lineHeight,
      x,
    );
    renderShadows(perpWallDist, x, drawStart, lineHeight);
  }

  void renderWall(
    GameEntity gameEntity,
    num wallX,
    int side,
    num rayDirX,
    num rayDirY,
    double drawStart,
    int lineHeight,
    int x,
  ) {
    ImageElement wallTexture;
    SpriteSheetComponent? spriteSheetComponent;

    spriteSheetComponent =
        gameEntity.getComponent('spriteSheet')! as SpriteSheetComponent;
    wallTexture = spriteSheetComponent.spriteSheet.image;

    final int perRow =
        spriteSheetComponent.spriteSheet.spriteSheetDefinition.perRow;
    final int perCol =
        spriteSheetComponent.spriteSheet.spriteSheetDefinition.perCol;

    final int xPosition = spriteSheetComponent
        .spriteSheet.spriteMap[spriteSheetComponent.spriteName]!.x
        .floor();
    final int yPosition = spriteSheetComponent
        .spriteSheet.spriteMap[spriteSheetComponent.spriteName]!.y
        .floor();

    // Calculate the width of each sprite
    final double spriteWidth = wallTexture.width! / perRow;
    final double spriteHeight = wallTexture.height! / perCol;

    // Calculate texX
    final int texX =
        (wallX * spriteWidth).floor() + (spriteWidth * xPosition).floor();
    final int sourceY = (spriteHeight * yPosition).floor();

    _renderer.renderClippedImage(
      image: wallTexture,
      sourceX: texX,
      sourceY: sourceY,
      sourceWidth: 1,
      sourceHeight: wallTexture.height! / perCol,
      destX: x,
      destY: drawStart,
      destWidth: 1,
      destHeight: lineHeight,
    );
  }

  void renderShadows(num perpWallDist, int x, num drawStart, int lineHeight) {
    final num lightRange = worldMap.worldDefinition.lightRange;
    final double calculatedAlpha =
        math.max((perpWallDist + 0.002) / lightRange, 0);

    _renderer.rect(
      x: x,
      y: drawStart.toInt(),
      width: 1,
      height: lineHeight + 1,
      color: Color(red: 0, green: 0, blue: 0, alpha: calculatedAlpha),
    );
  }

  double calculatePerpWall(
    int side,
    int mapX,
    int mapY,
    Camera camera,
    num wallXOffset,
    num wallYOffset,
    int stepX,
    int stepY,
    num rayDirX,
    num rayDirY,
  ) {
    double perpWallDist = 0;

    if (side == 0) {
      perpWallDist =
          (mapX - camera.xPos + wallXOffset + (1 - stepX) / 2) / rayDirX;
    } else if (side == 1) {
      perpWallDist =
          (mapY - camera.yPos + wallYOffset + (1 - stepY) / 2) / rayDirY;
    }

    return perpWallDist;
  }

  void drawSpritesAndTransparentWalls(Camera camera) {
    final List<num> spriteDistance = [];
    final List<int> order = [];
    final List<GameEntity> gameEntities = [];
    gameEntities.addAll(worldMap.worldDefinition.items);
    gameEntities.addAll(worldMap.worldDefinition.npcs);

    final List<AnimatedSpriteComponent> sprites = [];

    _spriteDistanceCalculations(
      gameEntities,
      sprites,
      spriteDistance,
      order,
      camera,
    );
    _combSort(order, spriteDistance);

    int tp = _transparentWalls.isNotEmpty ? _transparentWalls.length - 1 : -1;

    for (int i = 0; i < sprites.length; i++) {
      final num spriteX = sprites[order[i]].animatedSprite.x - camera.xPos;
      final num spriteY = sprites[order[i]].animatedSprite.y - camera.yPos;

      final double invDet =
          1.0 / (camera.xPlane * camera.yDir - camera.xDir * camera.yPlane);
      final double transformX =
          invDet * (camera.yDir * spriteX - camera.xDir * spriteY);
      final double transformY =
          invDet * (-camera.yPlane * spriteX + camera.xPlane * spriteY);

      if (transformY > 0) {
        while (tp >= 0) {
          final num tpDist = _calculateTransparentDistance(camera, tp);
          if (spriteDistance[i] < tpDist) {
            _transparentWalls[tp].draw();
          } else {
            break;
          }
          tp--;
        }

        _drawSprite(transformX, transformY, sprites, order, i);
      }
    }

    while (tp >= 0) {
      _transparentWalls[tp].draw();
      tp--;
    }
    _transparentWalls.clear();
  }

  num _calculateTransparentDistance(Camera camera, int tp) {
    return ((camera.xPos - _transparentWalls[tp].xMap) *
            (camera.xPos - _transparentWalls[tp].xMap)) +
        ((camera.yPos - _transparentWalls[tp].yMap) *
            (camera.yPos - _transparentWalls[tp].yMap));
  }

  void _drawSprite(
    double transformX,
    double transformY,
    List<AnimatedSpriteComponent> sprites,
    List<int> order,
    int i,
  ) {
    final int spriteHeight =
        (_renderer.getCanvasHeight() / transformY).abs().round();
    final double drawStartY =
        -spriteHeight / 2 + _renderer.getCanvasHeight() / 2;

    final double spriteScreenX =
        (_renderer.getCanvasWidth() / 2) * (1 + transformX / transformY);
    final int spriteWidth =
        (_renderer.getCanvasHeight() / transformY).abs().round();
    int drawStartX = (-spriteWidth / 2 + spriteScreenX).floor();
    int drawEndX = drawStartX + spriteWidth;

    int clipStartX = drawStartX;
    int clipEndX = drawEndX;

    if (drawStartX < -spriteWidth) {
      drawStartX = -spriteWidth;
    }

    if (drawEndX > _renderer.getCanvasWidth() + spriteWidth) {
      drawEndX = _renderer.getCanvasWidth() + spriteWidth;
    }

    for (int stripe = drawStartX; stripe <= drawEndX; stripe++) {
      if (stripe >= 0 && stripe < _zBuffer.length) {
        if (transformY > _zBuffer[stripe]) {
          if (stripe - clipStartX <= 1) {
            clipStartX = stripe;
          } else {
            clipEndX = stripe;
            break;
          }
        }
      }
    }

    final double scaleDelta =
        sprites[order[i]].animatedSprite.currentImage().width! / spriteWidth;
    int drawXStart = ((clipStartX - drawStartX) * scaleDelta).floor();

    if (drawXStart < 0) {
      drawXStart = 0;
    }

    int drawXEnd = ((clipEndX - clipStartX) * scaleDelta).floor() + 1;

    if (drawXEnd > sprites[order[i]].animatedSprite.currentImage().width!) {
      drawXEnd = sprites[order[i]].animatedSprite.currentImage().width!;
    }

    int drawWidth = clipEndX - clipStartX;

    if (drawWidth < 0) {
      drawWidth = 0;
    }

    _renderer.renderClippedImage(
      image: sprites[order[i]].animatedSprite.currentImage(),
      sourceX: drawXStart,
      sourceY: 0,
      sourceWidth: drawXEnd,
      sourceHeight: sprites[order[i]].animatedSprite.currentImage().height!,
      destX: clipStartX,
      destY: drawStartY,
      destWidth: drawWidth,
      destHeight: spriteHeight,
    );
  }

  void _spriteDistanceCalculations(
    List<GameEntity> gameEntities,
    List<AnimatedSpriteComponent> sprites,
    List<num> spriteDistance,
    List<int> order,
    Camera camera,
  ) {
    for (int i = 0; i < gameEntities.length; i++) {
      order.add(i);

      final GameEntity gameEntity = gameEntities[i];

      final AnimatedSpriteComponent animatedSpriteComponent =
          gameEntity.getComponent('animatedSprite')! as AnimatedSpriteComponent;

      final PositionComponent position =
          gameEntity.getComponent('position')! as PositionComponent;
      spriteDistance.add(
        (camera.xPos - position.x) * (camera.xPos - position.x) +
            (camera.yPos - position.y) * (camera.yPos - position.y),
      );

      final DistanceComponent distance =
          gameEntity.getComponent('distance')! as DistanceComponent;
      distance.distance = spriteDistance[i];

      animatedSpriteComponent.animatedSprite.x = position.x;
      animatedSpriteComponent.animatedSprite.y = position.y;

      sprites.add(animatedSpriteComponent);
    }
  }

  void drawSkyBox(Color groundColor, Color skyColor) {
    // Sky
    final skyBox = worldMap.worldDefinition.skyBox;

    if (skyBox != null) {
      _renderer.renderImage(
        image: skyBox.image,
        x: 0,
        y: 0,
        height: _renderer.getCanvasWidth(),
        width: _renderer.getCanvasHeight(),
      );
    } else {
      // Sky
      _renderer.rect(
        x: 0,
        y: 0,
        width: _renderer.getCanvasWidth(),
        height: _renderer.getCanvasHeight() / 2,
        color: worldMap.worldDefinition.skyColor,
      );

      final GameEntity player = _gameEntityRegistry.getSingleton('player');
      final CameraComponent cameraComponent =
          player.getComponent('camera')! as CameraComponent;

      const int circleX = 250;
      const int circleY = 50;

      final double angleToNorth =
          math.atan2(cameraComponent.camera.yDir, cameraComponent.camera.xDir);

      final double adjustedX = circleX - (cameraComponent.camera.xPos * 0.5);
      final double adjustedY =
          circleY - (cameraComponent.camera.yPos * 0.5) + sin(angleToNorth) * 2;

      _renderer.circle(
        x: adjustedX,
        y: adjustedY,
        radius: 15,
        color: Color(red: 200, green: 200, blue: 200),
      );
      _renderer.circle(
        x: adjustedX,
        y: adjustedY,
        radius: 20,
        color: Color(red: 255, green: 255, blue: 255, alpha: 0.015),
      );
    }

    // Ground

    /*
    Renderer.rect(0, Renderer.getCanvasHeight() / 2, Renderer.getCanvasWidth(),
        Renderer.getCanvasHeight(), worldMap.worldDefinition.floorColor);


     */

    _renderer.rectGradient(
      x: 0,
      y: _renderer.getCanvasHeight() / 2,
      width: _renderer.getCanvasWidth(),
      height: _renderer.getCanvasHeight(),
      startColor: worldMap.worldDefinition.skyColor.toString(),
      endColor: worldMap.worldDefinition.floorColor.toString(),
    );
  }

  void _combSort(List<int> order, List<num> dist) {
    final int amount = order.length;
    int gap = amount;
    bool swapped = false;

    while (gap > 1 || swapped) {
      gap = (gap * 10) ~/ 13;
      if (gap == 9 || gap == 10) {
        gap = 11;
      }
      if (gap < 1) {
        gap = 1;
      }
      swapped = false;
      for (int i = 0; i < amount - gap; i++) {
        final int j = i + gap;

        if (dist[i] < dist[j]) {
          final tempDist = dist[i];
          dist[i] = dist[j];
          dist[j] = tempDist;

          final tempOrder = order[i];
          order[i] = order[j];
          order[j] = tempOrder;

          swapped = true;
        }
      }
    }
  }

  void flushBuffer() {}
}
