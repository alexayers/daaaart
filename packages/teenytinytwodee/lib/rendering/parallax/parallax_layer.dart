import 'package:teenytinytwodee/rendering/animated_sprite.dart';

class ParallaxLayer {
  ParallaxLayer({
    required AnimatedSprite animatedSprite,
    required num x,
    required num y,
    required num width,
    required num height,
  })  : _animatedSprite = animatedSprite,
        _x = x,
        _y = y,
        _width = width,
        _height = height;

  final AnimatedSprite _animatedSprite;
  num _x;
  final num _y;
  final num _width;
  final num _height;

  void render(double speed) {
    _animatedSprite.render(
        x: _x - speed, y: _y, width: _width, height: _height);
  }
}
