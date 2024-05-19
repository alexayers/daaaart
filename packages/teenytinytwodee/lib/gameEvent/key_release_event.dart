import 'package:teenytinytwodee/gameEvent/game_event.dart';

class KeyReleaseEvent extends GameEvent {
  KeyReleaseEvent(int keyPress) : super('keyboardUpEvent', keyPress);
}
