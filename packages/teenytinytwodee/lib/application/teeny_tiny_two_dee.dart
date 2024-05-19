import 'dart:html';

import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/gameEvent/game_event.dart';
import 'package:teenytinytwodee/gameEvent/game_event_bus.dart';
import 'package:teenytinytwodee/gameEvent/key_press_event.dart';
import 'package:teenytinytwodee/gameEvent/key_release_event.dart';
import 'package:teenytinytwodee/gameEvent/screen_change_event.dart';
import 'package:teenytinytwodee/input/keyboard.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class TeenyTinyTwoDeeApp {
  TeenyTinyTwoDeeApp() {
    // ConfigurationManager.init(cfg);
    logger(LogType.info, 'TeenyTinyTwoDeeApp - Dart V: 0.0.1');

    window.onKeyDown.listen((KeyboardEvent event) {
      event.preventDefault();
      _gameEventBus.publish(KeyPressEvent(event.keyCode));
    });

    window.onKeyUp.listen((KeyboardEvent event) {
      event.preventDefault();
      _gameEventBus.publish(KeyReleaseEvent(event.keyCode));
    });

    _gameEventBus.register('keyboardDownEvent', (GameEvent gameEvent) {
      _currentGameScreen.keyboard(gameEvent.payload as int);
    });

    _gameEventBus.register('keyboardUpEvent', (GameEvent gameEvent) {});
  }
  // Duration for 60 FPS
  final GameEventBus _gameEventBus = GameEventBus();
  Map<String, GameScreen> _gameScreens = {};
  String? _currentScreenName;
  late GameScreen _currentGameScreen;
  final Renderer _renderer = Renderer();

  num _lastTimestamp = -1;
  final num _frameDuration = 1000 ~/ 60;

  void run(Map<String, GameScreen> gameScreens, String currentScreen) {
    _gameScreens = gameScreens;

    _gameScreens.forEach((key, gameScreen) {
      gameScreen.init();
    });

    _gameEventBus.register('__CHANGE_SCREEN__', (GameEvent gameEvent) {
      logger(LogType.info, gameEvent.payload.toString());

      if (_currentScreenName != null) {
        _currentGameScreen.onExit();
      }

      flushKeys();
      _currentScreenName = gameEvent.payload as String;

      _currentGameScreen = _gameScreens[_currentScreenName]!;
      _currentGameScreen.onEnter();
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
      _currentGameScreen.logicLoop();
      _renderer.clearScreen();
      _currentGameScreen.renderLoop();

      _lastTimestamp = currentTimestamp;
    }

    window.animationFrame.then((timestamp) => gameLoop());
  }
}
