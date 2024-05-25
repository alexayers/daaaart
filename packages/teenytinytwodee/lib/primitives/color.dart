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

  @override
  String toString() {
    return 'Color(red: $red, green: $green, blue: $blue, alpha: $alpha)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Color &&
        other.red == red &&
        other.blue == blue &&
        other.green == green &&
        other.alpha == alpha;
  }

  @override
  int get hashCode {
    return red.hashCode ^ blue.hashCode ^ green.hashCode ^ alpha.hashCode;
  }
}

Color black = Color(red: 0, green: 0, blue: 0, alpha: 1);
Color white = Color(red: 255, green: 255, blue: 255, alpha: 1);
Color ltGray = Color(red: 190, green: 190, blue: 190, alpha: 1);
Color red = Color(red: 206, green: 0, blue: 0, alpha: 1);
Color brightRed = Color(red: 255, green: 0, blue: 0, alpha: 1);
Color darkRed = Color(red: 115, green: 0, blue: 0, alpha: 1);
Color orange = Color(red: 206, green: 127, blue: 2, alpha: 1);
Color brightOrange = Color(red: 255, green: 138, blue: 0, alpha: 1);
Color yellow = Color(red: 206, green: 189, blue: 2, alpha: 1);
Color brightYellow = Color(red: 255, green: 234, blue: 0, alpha: 1);
Color blue = Color(red: 0, green: 0, blue: 255, alpha: 1);
Color green = Color(red: 0, green: 100, blue: 0, alpha: 1);
Color drkGray = Color(red: 100, green: 100, blue: 100, alpha: 1);
Color navyBlue = Color(red: 0, green: 0, blue: 128, alpha: 1);
Color deepBlue = Color(red: 0, green: 0, blue: 139, alpha: 1);
Color royalBlue = Color(red: 65, green: 105, blue: 225, alpha: 1);
Color skyBlue = Color(red: 135, green: 206, blue: 235, alpha: 1);
Color lightBlue = Color(red: 173, green: 216, blue: 230, alpha: 1);
Color midnightBlue = Color(red: 25, green: 25, blue: 112, alpha: 1);
Color forestGreen = Color(red: 34, green: 139, blue: 34, alpha: 1);
Color limeGreen = Color(red: 50, green: 205, blue: 50, alpha: 1);
Color paleGreen = Color(red: 152, green: 251, blue: 152, alpha: 1);
Color springGreen = Color(red: 0, green: 255, blue: 127, alpha: 1);
Color oliveGreen = Color(red: 107, green: 142, blue: 35, alpha: 1);
Color darkGreen = Color(red: 0, green: 100, blue: 0, alpha: 1);
Color chartreuse = Color(red: 127, green: 255, blue: 0, alpha: 1);
Color goldenrod = Color(red: 218, green: 165, blue: 32, alpha: 1);
Color khaki = Color(red: 240, green: 230, blue: 140, alpha: 1);
Color darkKhaki = Color(red: 189, green: 183, blue: 107, alpha: 1);
Color gold = Color(red: 255, green: 215, blue: 0, alpha: 1);
Color darkGold = Color(red: 204, green: 204, blue: 0, alpha: 1);
Color beige = Color(red: 245, green: 245, blue: 220, alpha: 1);
Color tan = Color(red: 210, green: 180, blue: 140, alpha: 1);
Color sandyBrown = Color(red: 244, green: 164, blue: 96, alpha: 1);
Color chocolate = Color(red: 210, green: 105, blue: 30, alpha: 1);
Color saddleBrown = Color(red: 139, green: 69, blue: 19, alpha: 1);
Color sienna = Color(red: 160, green: 82, blue: 45, alpha: 1);
Color brown = Color(red: 165, green: 42, blue: 42, alpha: 1);
Color maroon = Color(red: 128, green: 0, blue: 0, alpha: 1);
Color coral = Color(red: 255, green: 127, blue: 80, alpha: 1);
Color lightCoral = Color(red: 240, green: 128, blue: 128, alpha: 1);
Color hotPink = Color(red: 255, green: 105, blue: 180, alpha: 1);
Color deepPink = Color(red: 255, green: 20, blue: 147, alpha: 1);
Color fuchsia = Color(red: 255, green: 0, blue: 255, alpha: 1);
Color lavender = Color(red: 230, green: 230, blue: 250, alpha: 1);
Color thistle = Color(red: 216, green: 191, blue: 216, alpha: 1);
Color plum = Color(red: 221, green: 160, blue: 221, alpha: 1);
Color violet = Color(red: 238, green: 130, blue: 238, alpha: 1);
Color orchid = Color(red: 218, green: 112, blue: 214, alpha: 1);
Color indigo = Color(red: 75, green: 0, blue: 130, alpha: 1);
Color slateBlue = Color(red: 106, green: 90, blue: 205, alpha: 1);
Color darkSlateBlue = Color(red: 72, green: 61, blue: 139, alpha: 1);
Color turquoise = Color(red: 64, green: 224, blue: 208, alpha: 1);
Color lightSeaGreen = Color(red: 32, green: 178, blue: 170, alpha: 1);
Color cadetBlue = Color(red: 95, green: 158, blue: 160, alpha: 1);
Color aquamarine = Color(red: 127, green: 255, blue: 212, alpha: 1);
Color darkCyan = Color(red: 0, green: 139, blue: 139, alpha: 1);
Color teal = Color(red: 0, green: 128, blue: 128, alpha: 1);
Color powderBlue = Color(red: 176, green: 224, blue: 230, alpha: 1);
Color steelBlue = Color(red: 70, green: 130, blue: 180, alpha: 1);
Color cornflowerBlue = Color(red: 100, green: 149, blue: 237, alpha: 1);
Color deepSkyBlue = Color(red: 0, green: 191, blue: 255, alpha: 1);
Color dodgerBlue = Color(red: 30, green: 144, blue: 255, alpha: 1);
