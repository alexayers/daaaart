import 'package:teenytinytwodee/primitives/color.dart';

enum FontFamily { arial }

enum FontStyle { bold, italic, normal }

class Font {
  Font(this.family, this.size, this.color);
  String family = FontFamily.arial.toString();
  int size;
  FontStyle style = FontStyle.normal;
  Color color = white;
}
