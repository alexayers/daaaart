import 'package:teenytinytwodee/gui/button_widget.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class TextButtonWidget extends ButtonWidget {
  TextButtonWidget({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.color,
    required super.mouseOverColor,
    required super.onClick,
    required this.text,
    required this.font,
  });

  final Font font;
  final String text;
  final _renderer = Renderer();

  @override
  void render(num offsetX, num offsetY) {
    _renderer.rect(
      x: x + offsetX,
      y: y + offsetY,
      width: width,
      height: height,
      color: isMouseOver ? mouseOverColor : color,
    );

    _renderer.print(
      msg: text,
      x: x +
          offsetX +
          (width - _renderer.calculateTextWidth(text, font.family)) / 2,
      y: y +
          offsetY +
          (height + _renderer.calculateTextWidth(text, font.family)) / 2,
      font: font,
    );
  }
}
