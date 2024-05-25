import 'package:teenytinytwodee/gui/widget.dart';

abstract class GameScreenOverlay {
  void init();

  void renderLoop();

  void logicLoop();

  void keyboard(int keyCode);

  List<Widget> getWidgets();

  void onOpen();

  void onClose();
}
