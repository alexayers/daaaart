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
