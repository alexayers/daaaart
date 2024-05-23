import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class ButtonWidget extends Widget {
  ButtonWidget({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required this.color,
    required this.mouseOverColor,
    required super.onClick,
  });

  final _renderer = Renderer();
  final Color color;
  final Color mouseOverColor;

  @override
  void render(num offsetX, num offsetY) {
    _renderer.rect(
      x: x + offsetX,
      y: y + offsetY,
      width: width,
      height: height,
      color: isMouseOver ? mouseOverColor : color,
    );
  }

  @override
  void mouseClick(num x, num y, MouseButton mouseButton) {
    onClick?.call();
  }

  @override
  void mouseOver(num x, num y) {
    // TODO: implement mouseOver
  }
}
