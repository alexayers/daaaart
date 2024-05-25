import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';
import 'package:walking/screens/base_screen.dart';
import 'package:walking/screens/screens.dart';

class ExampleApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.baseScreen.name] = BaseScreen();

    super.run(gameScreens, Screens.baseScreen.name);
  }
}
