import 'package:teenytinytwodee/primitives/color.dart';

String rbgToHex(int red, int green, int blue) {
  try {
    return '#${componentToHex(red)}${componentToHex(green)}${componentToHex(blue)}';
  } catch (e) {
    return '#ffffff';
  }
}

String componentToHex(int component) {
  final String hex = component.toRadixString(16);
  return hex.length == 1 ? '0$hex' : hex;
}

Color hexToColor(String hex) {
  try {
    final int red = int.parse(hex.substring(1, 3), radix: 16);
    final int green = int.parse(hex.substring(3, 5), radix: 16);
    final int blue = int.parse(hex.substring(5, 7), radix: 16);
    return Color(red: red, green: green, blue: blue);
  } catch (e) {
    return Color(red: 255, green: 255, blue: 255);
  }
}
