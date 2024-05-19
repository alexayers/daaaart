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
