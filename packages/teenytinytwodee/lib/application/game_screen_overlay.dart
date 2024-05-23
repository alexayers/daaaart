import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';

abstract class GameScreenOverlay {
  void init();

  void renderLoop();

  void logicLoop();

  void keyboard(int keyCode);

  void mouseClick(double x, double y, MouseButton mouseButton);

  void mouseMove(double x, double y);

  List<Widget> getWidgets();

  void onOpen();

  void onClose();
}
