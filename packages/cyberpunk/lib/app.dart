import 'package:cyberpunk/screens/city_screen.dart';
import 'package:cyberpunk/screens/main_screen.dart';
import 'package:cyberpunk/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class App extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = MainScreen();
    gameScreens[Screens.cityScreen.name] = CityScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
