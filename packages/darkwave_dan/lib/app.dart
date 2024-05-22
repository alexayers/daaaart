import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';
import 'package:walking/screens/laundrymat_screen.dart';
import 'package:walking/screens/screens.dart';

class ExampleApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.laundryMatScreen.name] = LaundryMatScreen();

    super.run(gameScreens, Screens.laundryMatScreen.name);
  }
}
