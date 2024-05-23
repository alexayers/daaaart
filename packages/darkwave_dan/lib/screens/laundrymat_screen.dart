import 'dart:html';

import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:teenytinytwodee/gameEvent/open_overlay_event.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/rendering/parallax/parallax_layer.dart';
import 'package:teenytinytwodee/rendering/parallax/parallax_renderer.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';
import 'package:walking/screens/instruments/drum_machine_overlay.dart';

class LaundryMatScreen implements GameScreen {
  final _renderer = Renderer();
  final _paralaxRenderer = ParallaxRenderer(3, [0.5, 1, 1.5]);
  final _gameEventBus = GameEventBus();
  num _xPosition = 0;

  final AnimatedSprite _man = AnimatedSprite(
    maxTicks: 12,
    imageFiles: {
      'default': [
        'assets/images/walking1.png',
        'assets/images/walking2.png',
        'assets/images/walking1.png',
        'assets/images/walking3.png',
      ],
    },
    currentAction: 'default',
  );

  @override
  void init() {
    _paralaxRenderer.addLayer(
      1,
      ParallaxLayer(
        animatedSprite: AnimatedSprite(
          currentAction: 'default',
          imageFiles: {
            'default': [
              'assets/images/washingMachine.png',
            ],
          },
        ),
        x: 150,
        y: 290,
        width: 64,
        height: 112,
      ),
    );
  }

  @override
  void keyboard(int keyCode) {
    switch (keyCode) {
      case KeyCode.LEFT:
        if (_xPosition > 0) {
          _xPosition -= 1;
        }

      case KeyCode.RIGHT:
        _xPosition += 1;
    }
  }

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

  void _background() {
    // Sky
    _renderer.rect(
      x: 0,
      y: 0,
      width: _renderer.getCanvasWidth(),
      height: _renderer.getCanvasHeight(),
      color: hexToColor('#1b0c1e'),
    );

    // Parking lot
    _renderer.rect(
      x: 0,
      y: _renderer.getCanvasHeight() - 200,
      width: _renderer.getCanvasWidth(),
      height: _renderer.getCanvasHeight(),
      color: hexToColor('#141414'),
    );

    // Sidewalk
    _renderer.rect(
      x: 0,
      y: _renderer.getCanvasHeight() - 200,
      width: _renderer.getCanvasWidth(),
      height: 25,
      color: hexToColor('#383838'),
    );
  }

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

    _paralaxRenderer.render(_xPosition);

    _man.render(x: 250, y: 280, width: 64, height: 128);

    _wideScreenOverlay();
  }

  @override
  Map<String, GameScreenOverlay> get overLayScreens {
    return {
      'drumMachine': DrumMachineOverlay(),
    };
  }
}
