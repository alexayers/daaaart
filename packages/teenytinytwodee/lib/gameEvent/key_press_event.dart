import 'package:teenytinytwodee/gameEvent/game_event.dart';

class KeyPressEvent extends GameEvent {
  KeyPressEvent(int keyPress) : super('keyboardDownEvent', keyPress);
}
