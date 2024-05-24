import 'dart:math';

class Vector2 {
  Vector2(this.x, this.y);
  final num x;
  final num y;

  // Normalize the vector
  Vector2 normalize() {
    final double length = sqrt(x * x + y * y);
    return Vector2(x / length, y / length);
  }

  double get angle => atan2(y, x);

  // Calculate the dot product
  num dot(Vector2 other) {
    return x * other.x + y * other.y;
  }
}

num getDecimal(num d) {
  return d - d.floor();
}

Point rotateVector(num vx, num vy, num angle) {
  return Point(
    vx * cos(angle) - vy * sin(angle),
    vx * sin(angle) + vy * cos(angle),
  );
}

bool isPointWithinQuad({
  required Point point,
  required num x,
  required num y,
  required num width,
  required num height,
}) {
  if (point.x >= x &&
      point.x <= x + width &&
      point.y >= y &&
      point.y <= y + height) {
    return true;
  } else {
    return false;
  }
}

bool isPointWithinCircle({
  required Point point,
  required num cx,
  required num cy,
  required num radius,
}) {
  final num dx = point.x - cx;
  final num dy = point.y - cy;
  final num distanceSquared = dx * dx + dy * dy;
  final num radiusSquared = radius * radius;

  return distanceSquared <= radiusSquared;
}

int getRandomInt(int max) {
  final rng = Random();
  return rng.nextInt(max) + 1;
}

int getRandomBetween(int min, int max) {
  final rng = Random();
  return rng.nextInt(max - min + 1) + min;
}

dynamic getRandomArrayElement(List<dynamic> array) {
  return array[getRandomBetween(0, array.length - 1)];
}

num distanceBetweenTwoPixelCoords({
  required num x1,
  required num y1,
  required num x2,
  required num y2,
}) {
  return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}

num calculateXPercentOfY(int x, int y) {
  return (x / 100) * y;
}

num calculatePercent(int current, int total) {
  return ((current / total) * 100).floor();
}
