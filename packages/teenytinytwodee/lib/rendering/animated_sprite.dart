import 'dart:html';

import 'package:teenytinytwodee/rendering/renderer.dart';

class AnimatedSprite {
  AnimatedSprite(
    Map<String, List<String>> imageFiles,
    this.width,
    this.height,
    this._currentAction,
  ) {
    for (final String key in imageFiles.keys) {
      _frames[key] = [];
      for (final String image in imageFiles[key]!) {
        final ImageElement imageElement = ImageElement();
        imageElement.src = image;
        _frames[key]!.add(imageElement);
      }
    }

    _currentFrame = 0;
    _tick = 0;
  }
  int _tick = 0;
  num x = 0;
  num y = 0;
  num width;
  num height;
  final int _maxTicks = 8;
  int _currentFrame = 0;
  String _currentAction;
  final Map<String, List<ImageElement>> _frames = {};
  final Renderer _renderer = Renderer();

  void nextFrame() {
    _tick++;

    if (_tick == _maxTicks) {
      _tick = 0;
      _currentFrame++;

      if (_currentFrame == _frames[_currentAction]!.length) {
        _currentFrame = 0;
      }
    }
  }

  set currentAction(String action) {
    if (action != _currentAction) {
      _currentAction = action;
      _currentFrame = 0;
    }
  }

  String get currentAction => _currentAction;

  void render(num x, num y, int width, int height) {
    final ImageElement imageElement = _frames[_currentAction]![_currentFrame];
    _renderer.renderImage(
      image: imageElement,
      x: x,
      y: y,
      width: width,
      height: height,
    );

    _tick++;

    if (_tick == _maxTicks) {
      _tick = 0;
      _currentFrame++;

      if (_currentFrame == _frames[_currentAction]!.length) {
        _currentFrame = 0;
      }
    }
  }

  ImageElement currentImage() {
    return _frames[_currentAction]![_currentFrame];
  }
}
