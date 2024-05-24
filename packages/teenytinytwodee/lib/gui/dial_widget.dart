import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class DialWidget extends Widget {
  DialWidget({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required this.radius,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.color,
    required this.mouseOverColor,
  });

  final _renderer = Renderer();
  num currentValue = 50;
  num minValue = 0;
  num maxValue = 100;
  num radius = 5;
  Color color;
  Color mouseOverColor;

  @override
  void mouseClick(num x, num y, MouseButton mouseButton) {
    // TODO: implement mouseClick
  }

  @override
  void mouseOver(num x, num y) {
    // TODO: implement mouseOver
  }

  @override
  void render(num offsetX, num offsetY) {
    _renderer.circle(
      x: x + offsetX,
      y: y + offsetY,
      radius: radius,
      color: isMouseOver ? mouseOverColor : color,
    );
  }
}
