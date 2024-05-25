import 'package:teenytinytwodee/gameEvent/game_event.dart';

class OpenOverlayScreenEvent extends GameEvent {
  OpenOverlayScreenEvent(String destinationScreen)
      : super('__OPEN_OVERLAY_SCREEN__', destinationScreen);
}
