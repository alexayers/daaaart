import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:teenytinytwodee/gameEvent/open_overlay_event.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:walking/screens/instruments/drum_machine_overlay.dart';

class BaseScreen implements GameScreen {
  final _renderer = Renderer();
  final _gameEventBus = GameEventBus();

  @override
  void init() {}

  @override
  void keyboard(int keyCode) {}

  @override
  void logicLoop() {}

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {}

  @override
  void mouseMove(double x, double y) {}

  @override
  void onEnter() {
    _gameEventBus.publish(OpenOverlayScreenEvent('drumMachine'));
  }

  @override
  void onExit() {}

  void _background() {}

  void _wideScreenOverlay() {
    _renderer.rect(
      x: 0,
      y: 0,
      width: _renderer.getCanvasWidth(),
      height: 100,
      color: black,
    );

    _renderer.rect(
      x: 0,
      y: _renderer.getCanvasHeight() - 100,
      width: _renderer.getCanvasWidth(),
      height: 100,
      color: black,
    );
  }

  @override
  void renderLoop() {
    _background();

    _wideScreenOverlay();
  }

  @override
  Map<String, GameScreenOverlay> get overLayScreens {
    return {
      'drumMachine': DrumMachineOverlay(),
    };
  }
}
