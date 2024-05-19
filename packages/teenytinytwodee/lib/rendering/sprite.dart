import 'dart:html';

import 'package:teenytinytwodee/rendering/renderer.dart';

class Sprite {
  Sprite(this.width, this.height, String imageFile) : image = ImageElement() {
    image.src = imageFile;
  }
  num width;
  num height;
  num x = 0;
  num y = 0;
  num z = 0;
  ImageElement image;

  void render(num x, num y, int width, int height, [bool flip = false]) {
    final renderer = Renderer();
    renderer.renderImage(
      image: image,
      x: x,
      y: y,
      width: width,
      height: height,
      flip: flip,
    );
  }
}
