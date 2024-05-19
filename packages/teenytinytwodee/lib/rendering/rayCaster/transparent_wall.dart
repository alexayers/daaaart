import 'package:teenytinytwodee/rendering/rayCaster/camera.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

class TransparentWall {
  TransparentWall(
    this.sprite,
    this.camera,
    this.xMap,
    this.yMap,
    this.side,
    this.xScreen,
    this.cameraXCoords,
  );
  int xMap;
  int yMap;
  int side;
  int xScreen;
  Camera camera;
  List<num> cameraXCoords;
  Sprite sprite;
  final Renderer _renderer = Renderer();

  num getRayDir(int x) {
    if (side == 1) {
      return camera.yDir + camera.yPlane * cameraXCoords[x];
    } else {
      return camera.xDir + camera.xPlane * cameraXCoords[x];
    }
  }

  num getPrepDist(int x) {
    int step = 1;
    final num rayDir = getRayDir(x);

    if (rayDir < 0) {
      step = -1;
    }

    if (side == 1) {
      return (yMap - camera.yPos + (0.5 * step) + (1 - step) / 2) / rayDir;
    } else {
      return (xMap - camera.xPos + (0.5 * step) + (1 - step) / 2) / rayDir;
    }
  }

  void draw() {
    _renderer.saveContext();
    _renderer.alpha = 0.8;

    final num perpDist = getPrepDist(xScreen);
    final int lineHeight = (_renderer.getCanvasHeight() / perpDist).round();
    final num drawStart = -lineHeight / 2 + _renderer.getCanvasHeight() / 2;

    num wallX = 0;
    if (side == 0) {
      wallX = camera.yPos + perpDist * getRayDir(xScreen);
    } else if (side == 1) {
      wallX = camera.xPos + perpDist * getRayDir(xScreen);
    }

    wallX -= wallX.floor();

    final int texX = (wallX * sprite.image.width!).floor();
    _renderer.renderClippedImage(
      image: sprite.image,
      sourceX: texX,
      sourceY: 0,
      sourceWidth: 1,
      sourceHeight: sprite.image.height!,
      destX: xScreen,
      destY: drawStart,
      destWidth: 1,
      destHeight: lineHeight,
    );

    _renderer.restoreContext();
  }
}
