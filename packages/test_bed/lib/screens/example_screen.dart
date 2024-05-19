import 'dart:html';

import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

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
    renderer.print(
      msg: 'Hello World',
      x: 50,
      y: 50,
      font: Font(
        'Arial',
        40,
        Color(red: 255, green: 255, blue: 255),
      ),
    );
  }
}
