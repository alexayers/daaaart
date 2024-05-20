import 'package:teenytinytwodee/primitives/color.dart';

class Particle {
  Particle({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.alpha,
    required this.lifeSpan,
    required this.decayRate,
    required this.velX,
    required this.velY,
    required this.color,
    this.circle = false,
  });
  num x;
  num y;
  num width;
  num height;
  num alpha;
  num lifeSpan;
  num decayRate;
  num velX;
  num velY;
  bool circle;
  Color color = Color(red: 255, green: 255, blue: 255);
}
