import 'dart:html';

import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class ExampleScreen implements GameScreen {
  final renderer = Renderer();

  @override
  void init() {
    logger(LogType.info, 'init');
  }

  @override
  void keyboard(int keyCode) {
    switch (keyCode) {
      case KeyCode.A:
        logger(LogType.info, 'A key pressed');

      default:
        logger(LogType.info, 'Not A');
    }
  }

  @override
  void logicLoop() {}

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {}

  @override
  void mouseMove(double x, double y) {}

  @override
  void onEnter() {}

  @override
  void onExit() {}

  @override
  void renderLoop() {
    renderer.renderImage(
      image: ImageElement(src: 'assets/face.png'),
      x: 0 + getRandomBetween(1, 500),
      y: 0 + getRandomBetween(1, 500),
      width: 50 + getRandomBetween(1, 500),
      height: 50 + getRandomBetween(1, 500),
    );

    renderer.rect(
      x: 0 + getRandomBetween(1, 500),
      y: 0 + getRandomBetween(1, 500),
      width: 50 + getRandomBetween(1, 500),
      height: 50 + getRandomBetween(1, 500),
      color: Color(
        red: getRandomBetween(1, 255),
        green: getRandomBetween(1, 255),
        blue: getRandomBetween(1, 255),
      ),
    );

    renderer.print(
      msg: 'Hello World',
      x: 50 + getRandomBetween(1, 500),
      y: 50 + getRandomBetween(1, 500),
      font: Font(
        'Arial',
        500,
        Color(
          red: getRandomBetween(1, 255),
          green: getRandomBetween(1, 255),
          blue: getRandomBetween(1, 255),
        ),
      ),
    );
  }
}
