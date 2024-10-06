import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class TextWidget extends Widget {
  TextWidget({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required this.text,
    required this.font,
  });

  String text = '';
  Font font;
  final _renderer = Renderer();

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
    _renderer.print(
      msg: text,
      x: x + offsetX,
      y: y + offsetY,
      font: font,
    );
  }
}
