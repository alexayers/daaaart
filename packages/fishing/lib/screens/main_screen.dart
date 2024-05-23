import 'dart:html';

import 'package:cyberpunk/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:teenytinytwodee/gameEvent/screen_change_event.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class MainScreen implements GameScreen {
  final GameEventBus _gameEventBus = GameEventBus();
  final Renderer _renderer = Renderer();

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void keyboard(int keyCode) {
    if (keyCode == KeyCode.A) {
      _gameEventBus.publish(ScreenChangeEvent(Screens.cityScreen.name));
    }
  }

  @override
  void logicLoop() {
    // TODO: implement logicLoop
  }

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {
    // TODO: implement mouseClick
  }

  @override
  void mouseMove(double x, double y) {
    // TODO: implement mouseMove
  }

  @override
  void onEnter() {
    // TODO: implement onEnter
  }

  @override
  void onExit() {
    // TODO: implement onExit
  }

  @override
  void renderLoop() {
    _renderer.print(
      msg: 'Press A to catch fish',
      x: 350,
      y: 250,
      font: Font('Arial', 500, Color(red: 255, green: 255, blue: 255)),
    );
  }

  @override
  // TODO: implement overLayScreens
  Map<String, GameScreenOverlay> get overLayScreens =>
      throw UnimplementedError();
}
