import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';
import 'package:test_bed/screens/example_screen.dart';
import 'package:test_bed/screens/screens.dart';

class ExampleApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.exampleScreen.name] = ExampleScreen();

    super.run(gameScreens, Screens.exampleScreen.name);
  }
}
