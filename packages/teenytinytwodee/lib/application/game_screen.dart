import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/input/mouse.dart';

abstract class GameScreen {
  void init();

  void onEnter();

  void onExit();

  void logicLoop();

  void renderLoop();

  Map<String, GameScreenOverlay> get overLayScreens;

  void keyboard(int keyCode);

  void mouseClick(double x, double y, MouseButton mouseButton);

  void mouseMove(double x, double y);
}
