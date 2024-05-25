import 'package:teenytinytwodee/input/mouse.dart';

abstract class Widget {
  Widget({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.onClick,
  });

  String id;
  num x;
  num y;
  num width;
  num height;
  bool isMouseOver = false;
  void Function()? onClick;

  void render(num offsetX, num offsetY);
  void mouseOver(num x, num y);
  void mouseClick(num x, num y, MouseButton mouseButton);
}
