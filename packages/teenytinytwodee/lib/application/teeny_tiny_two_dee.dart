import 'dart:html';

import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/gameEvent/game_event.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:teenytinytwodee/gameEvent/key_press_event.dart';
import 'package:teenytinytwodee/gameEvent/key_release_event.dart';
import 'package:teenytinytwodee/gameEvent/screen_change_event.dart';
import 'package:teenytinytwodee/gui/widget_manager.dart';
import 'package:teenytinytwodee/input/keyboard.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class TeenyTinyTwoDeeApp {
  TeenyTinyTwoDeeApp() {
    // ConfigurationManager.init(cfg);
    _logger.info('TeenyTinyTwoDeeApp - Dart V: 0.0.1');

    window.onKeyDown.listen((KeyboardEvent event) {
      event.preventDefault();
      _gameEventBus.publish(KeyPressEvent(event.keyCode));
    });

    window.onMouseMove.listen((MouseEvent event) {
      event.preventDefault();

      final rect = _renderer.getBoundingClientRect();
      final canvasX = (event.client.x - rect.left) *
          _renderer.getCanvasWidth() ~/
          rect.width;
      final canvasY = (event.client.y - rect.top) *
          _renderer.getCanvasHeight() ~/
          rect.height;

      if (_currentGameScreenOverlay != null) {
        _widgetManagers[_currentOverlayScreenName]!.mouseOver(canvasX, canvasY);
        return;
      }
    });

    window.onMouseDown.listen((MouseEvent event) {
      event.preventDefault();
      if (_currentGameScreenOverlay != null) {
        final mouseButton = switch (event.button) {
          0 => MouseButton.left,
          1 => MouseButton.middle,
          2 => MouseButton.right,
          _ => MouseButton.unknown,
        };

        final rect = _renderer.getBoundingClientRect();
        final canvasX = (event.client.x - rect.left) *
            _renderer.getCanvasWidth() ~/
            rect.width;
        final canvasY = (event.client.y - rect.top) *
            _renderer.getCanvasHeight() ~/
            rect.height;

        _widgetManagers[_currentOverlayScreenName]!
            .mouseClick(canvasX, canvasY, mouseButton);
        return;
      }
    });

    window.onKeyUp.listen((KeyboardEvent event) {
      event.preventDefault();
      _gameEventBus.publish(KeyReleaseEvent(event.keyCode));
    });

    _gameEventBus.register('keyboardDownEvent', (GameEvent gameEvent) {
      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.keyboard(gameEvent.payload as int);
        return;
      }
      _currentGameScreen.keyboard(gameEvent.payload as int);
    });

    _gameEventBus.register('keyboardUpEvent', (GameEvent gameEvent) {});
  }
  // Duration for 60 FPS

  final Logger _logger = Logger();
  final GameEventBus _gameEventBus = GameEventBus();
  Map<String, GameScreen> _gameScreens = {};
  final Map<String, GameScreenOverlay> _gameScreenOverlays = {};
  String? _currentScreenName;
  String? _currentOverlayScreenName;
  GameScreenOverlay? _currentGameScreenOverlay;
  late GameScreen _currentGameScreen;
  final Renderer _renderer = Renderer();
  final Map<String, WidgetManager> _widgetManagers = {};

  num _lastTimestamp = -1;
  final num _frameDuration = 1000 ~/ 60;

  void run(Map<String, GameScreen> gameScreens, String currentScreen) {
    _gameScreens = gameScreens;

    _gameScreens.forEach((key, gameScreen) {
      gameScreen.init();

      _widgetManagers[key] = WidgetManager();

      gameScreen.overLayScreens.forEach((key, value) {
        value.init();
        _gameScreenOverlays[key] = value;
        _widgetManagers[key] = WidgetManager();
        _widgetManagers[key]!.addAllWidgets(value.getWidgets());
        _logger.info('Initialized overlay screen: $key');
      });
    });

    _gameEventBus.register('__CHANGE_SCREEN__', (GameEvent gameEvent) {
      _logger.info(gameEvent.payload.toString());

      if (_currentScreenName != null) {
        _currentGameScreen.onExit();
      }

      flushKeys();
      _currentScreenName = gameEvent.payload as String;

      _currentGameScreen = _gameScreens[_currentScreenName]!;
      _currentGameScreen.onEnter();
    });

    _gameEventBus.register('__CLOSE_OVERLAY_SCREEN__', (GameEvent gameEvent) {
      _logger.info(gameEvent.payload.toString());

      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.onClose();
      }

      _currentGameScreenOverlay = null;
    });

    _gameEventBus.register('__OPEN_OVERLAY_SCREEN__', (GameEvent gameEvent) {
      _logger.info(gameEvent.payload.toString());

      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.onClose();
      }

      flushKeys();
      _currentOverlayScreenName = gameEvent.payload as String;

      _currentGameScreenOverlay =
          _gameScreenOverlays[_currentOverlayScreenName];

      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.onOpen();
      }
    });

    _gameEventBus.publish(ScreenChangeEvent(currentScreen));
    gameLoop();
  }

  void gameLoop() {
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (_lastTimestamp < 0) {
      _lastTimestamp = currentTimestamp;
    }

    final num deltaTime = currentTimestamp - _lastTimestamp;

    if (deltaTime >= _frameDuration) {
      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.logicLoop();
      } else {
        _currentGameScreen.logicLoop();
      }

      _renderer.clearScreen();
      _currentGameScreen.renderLoop();

      if (_currentGameScreenOverlay != null) {
        _currentGameScreenOverlay!.renderLoop();
        _widgetManagers[_currentOverlayScreenName]!.render(0, 0);
      }

      _lastTimestamp = currentTimestamp;
    }

    window.animationFrame.then((timestamp) => gameLoop());
  }
}
