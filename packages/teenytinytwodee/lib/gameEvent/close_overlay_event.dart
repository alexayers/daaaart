import 'package:teenytinytwodee/gameEvent/game_event.dart';

class CloseOverlayScreenEvent extends GameEvent {
  CloseOverlayScreenEvent(String destinationScreen)
      : super('__CLOSE_OVERLAY_SCREEN__', destinationScreen);
}
