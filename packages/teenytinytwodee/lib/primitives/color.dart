class Color {
  Color({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha = 1.0,
  });
  int red;
  int blue;
  int green;
  num alpha;
}

Color black = Color(red: 0, green: 0, blue: 0, alpha: 1);
Color white = Color(red: 255, green: 255, blue: 255, alpha: 1);
Color ltGray = Color(red: 190, green: 190, blue: 190, alpha: 1);
Color red = Color(red: 255, green: 0, blue: 0, alpha: 1);
Color blue = Color(red: 0, green: 0, blue: 255, alpha: 1);
Color green = Color(red: 0, green: 100, blue: 0, alpha: 1);
Color drkGray = Color(red: 100, green: 100, blue: 100, alpha: 1);
