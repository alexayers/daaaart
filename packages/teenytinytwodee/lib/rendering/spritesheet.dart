import 'dart:html';

import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class SpriteSheetDefinition {
  SpriteSheetDefinition(
    this.spriteSheet,
    this.sprites,
    this.spriteWidth,
    this.spriteHeight,
  );

  String spriteSheet;
  int spriteWidth;
  int spriteHeight;
  late int perRow;
  late int perCol;
  List<String> sprites;
}

class SpriteLocation {
  SpriteLocation(this.lx, this.ly, this.hx, this.hy);
  int lx;
  int ly;
  int hx;
  int hy;
}

class SpriteSheet {
  SpriteSheet(this.spriteSheetDefinition) {
    const int offsetX = 0;
    const int offsetY = 0;
    image.src = spriteSheetDefinition.spriteSheet;

    image.onLoad.listen((event) {
      final int width = image.width!;
      final int height = image.height!;
      final int spritesPerRow =
          (width / spriteSheetDefinition.spriteWidth).floor();
      final int spritesPerCol =
          (height / spriteSheetDefinition.spriteHeight).floor();

      int x = 0; // x position in sprite terms
      int y = 0; // y position in sprite terms

      for (final String spriteName in spriteSheetDefinition.sprites) {
        spriteMap[spriteName] = Vector2(x, y);

        _logger.info('Loaded $spriteName at ${offsetX}x$offsetY');

        x++;

        // Check if we reached the end of the row
        if (x >= spritesPerRow) {
          x = 0; // Reset column position for sprites
          y++;
        }
      }

      spriteSheetDefinition.perRow = spritesPerRow;
      spriteSheetDefinition.perCol = spritesPerCol;
    });
  }

  final _logger = Logger();
  late final SpriteSheetDefinition spriteSheetDefinition;
  final Map<String, Vector2> spriteMap = {};
  final ImageElement image = ImageElement();

  /*
  void render(String spriteName, num x, num y, int width, int height, [bool flip = false]) {

    SpriteLocation spriteLocation = _spriteMap[spriteName]!;
    Renderer.renderClippedImage(image, spriteLocation.lx, spriteLocation.ly, spriteSheetDefinition.spriteWidth, spriteSheetDefinition.spriteHeight,
        x, y, width, height);

  }

   */
}
