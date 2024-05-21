import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

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

class ParticleRenderer {
  final _renderer = Renderer();

  void render(
    List<Particle> particles,
    Particle Function() refreshParticle,
  ) {
    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];

      _renderer.rect(
        x: particle.x,
        y: particle.y,
        width: particle.width,
        height: particle.height,
        color: particle.color,
      );

      particle.x += particle.velX;
      particle.y += particle.velY;
      particle.color.alpha -= particle.decayRate;

      particle.lifeSpan -= particle.decayRate;

      if (particle.lifeSpan <= 0 ||
          particle.y > _renderer.getCanvasHeight() ||
          particle.x > _renderer.getCanvasWidth() ||
          particle.y < 0 ||
          particle.x < 0) {
        particles[i] = refreshParticle();
      }
    }
  }
}
