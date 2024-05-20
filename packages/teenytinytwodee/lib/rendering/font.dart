import 'package:teenytinytwodee/primitives/color.dart';

enum FontFamily { arial }

enum FontStyle { bold, italic, normal }

class Font {
  Font(this.family, this.size, this.color);
  final String family;
  final int size;
  final FontStyle style = FontStyle.normal;
  final Color color;
}
