import 'dart:html';

import 'package:cyberpunk/objects/dog.dart';
import 'package:cyberpunk/objects/hacker.dart';
import 'package:cyberpunk/objects/robot.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/rendering/particle.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class CityScreen implements GameScreen {
  final renderer = Renderer();
  final List<Particle> _backgroundRainParticles = [];
  final List<Particle> _foregroundRainParticles = [];
  final List<Particle> _fogParticles = [];
  final _hacker = Hacker();
  final _dog = Dog();
  final _robot = Robot();
  final _renderer = Renderer();
  final _audioManager = AudioManager();

  bool _trainLeft = true;
  num _trainX = 900;
  int _fishZone = 0;
  int _totalFishCaught = 0;
  int _lastFishCaught = 0;
  int _currentFishZone = 0;
  num _fishTimer = 0;
  int _currentFishZoneSpeed = 1;
  bool _fishZoneLeft = true;
  bool _fishOnTheLine = false;

  final AnimatedSprite _birdFly = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/birdFly1.png',
        'assets/images/birdFly2.png',
        'assets/images/birdFly3.png',
        'assets/images/birdFly2.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite _lightPost = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/lightPost.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite _buoy = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/buoy.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite _seagull = AnimatedSprite(
    maxTicks: 32,
    imageFiles: {
      'default': [
        'assets/images/bird1.png',
        'assets/images/bird2.png',
        'assets/images/bird3.png',
        'assets/images/bird4.png',
        'assets/images/bird5.png',
        'assets/images/bird6.png',
        'assets/images/bird5.png',
        'assets/images/bird4.png',
        'assets/images/bird3.png',
        'assets/images/bird2.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite _neonSign = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/sign1.png',
        'assets/images/sign2.png',
        'assets/images/sign3.png',
        'assets/images/sign4.png',
        'assets/images/sign5.png',
        'assets/images/sign4.png',
        'assets/images/sign3.png',
        'assets/images/sign2.png',
      ],
    },
    currentAction: 'default',
  );

  final _trash = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/trash.png',
      ],
    },
    currentAction: 'default',
  );

  bool _waterRise = true;
  double _waterLevel = 0;

  @override
  void init() {
    logger(LogType.info, 'init');

    _audioManager.register('bulletTrain', 'assets/audio/bulletTrain.mp3');
    _audioManager.register('harbor', 'assets/audio/harbor.mp3', true);

    for (int i = 0; i < 1000; i++) {
      _fogParticles.add(
        _refreshFogParticle(),
      );
    }

    for (int i = 0; i < 200; i++) {
      _backgroundRainParticles.add(
        _refreshRainParticle(),
      );
    }

    for (int i = 0; i < 100; i++) {
      _foregroundRainParticles.add(
        _refreshRainParticle(),
      );
    }
  }

  @override
  void keyboard(int keyCode) {
    if (_fishOnTheLine) {
      switch (keyCode) {
        case KeyCode.A:
          if (_isFishCaught()) {
            logger(LogType.info, 'Got em');
            _totalFishCaught++;
            _fishOnTheLine = false;
            _lastFishCaught = DateTime.now().millisecondsSinceEpoch;
          }
      }
    }
  }

  bool _isFishCaught() {
    if (isPointWithinQuad(
      Point(302 + _currentFishZone, 252),
      302 + _fishZone,
      252,
      32,
      28,
    )) {
      return true;
    }

    return false;
  }

  @override
  void logicLoop() {
    if (getRandomBetween(1, 100) < 5 &&
        !_fishOnTheLine &&
        DateTime.now().millisecondsSinceEpoch - _lastFishCaught > 5000) {
      _fishOnTheLine = true;
      _fishZone = getRandomBetween(0, 160);
      _fishTimer = 0;
      _currentFishZoneSpeed = getRandomBetween(1, 20);
    }
  }

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {}

  @override
  void mouseMove(double x, double y) {}

  @override
  void onEnter() {
    _audioManager.play('harbor');
  }

  @override
  void onExit() {}

  Particle _refreshRainParticle() {
    return Particle(
      x: getRandomBetween(0, 800),
      y: getRandomBetween(-500, 250),
      width: 1,
      height: 80,
      alpha: 0.15,
      lifeSpan: getRandomBetween(400, 800),
      decayRate: getRandomBetween(1, 5),
      velX: getRandomBetween(1, 10) / 10,
      velY: getRandomBetween(50, 70),
      color: Color(
        red: 100,
        green: 100,
        blue: 100,
      ),
    );
  }

  Particle _refreshFogParticle() {
    return Particle(
      x: getRandomBetween(0, 800),
      y: getRandomBetween(600, 800),
      width: getRandomBetween(50, 150),
      height: getRandomBetween(40, 128),
      alpha: 0.15,
      lifeSpan: getRandomBetween(1, 100),
      decayRate: getRandomBetween(1, 5),
      velX: getRandomBetween(1, 10) / 200,
      velY: 0,
      color: Color(
        red: 160,
        green: 160,
        blue: 160,
        alpha: 0.01,
      ),
      circle: true,
    );
  }

  void _train() {
    const int trainSize = 2000;

    for (int i = 0; i < trainSize; i += 220) {
      renderer.rect(
        x: 0 + i,
        y: 100,
        width: 70,
        height: 600,
        color: hexToColor('#000000'),
      );
    }

    for (int i = 0; i < trainSize; i += 125) {
      renderer.rect(
        x: _trainX + i,
        y: 200,
        width: 120,
        height: 50,
        color: hexToColor('#42280c'),
      );

      // Windows
      renderer.rect(
        x: _trainX + i,
        y: 200,
        width: 100,
        height: 32,
        color: hexToColor('#444444'),
      );

      renderer.rect(
        x: _trainX + i,
        y: 240,
        width: 120,
        height: 10,
        color: hexToColor('#2d1b08'),
      );

      if (_trainX < -16000) {
        _trainLeft = false;
        //  _audioManager.play('bulletTrain');
      }

      if (_trainX > 16000) {
        //   _audioManager.play('bulletTrain');
        _trainLeft = true;
      }

      if (_trainLeft) {
        _trainX -= 4;
      } else {
        _trainX += 4;
      }
    }

    // tracks
    renderer.rect(
      x: 0,
      y: 250,
      width: 800,
      height: 10,
      color: hexToColor('#000000'),
    );
  }

  void _backgroundBuildings() {
    // Moon
    renderer.circle(
      x: 740,
      y: 100,
      radius: 30,
      color: Color(
        red: 255,
        green: 255,
        blue: 255,
      ),
    );

    renderer.circle(
      x: 740,
      y: 100,
      radius: 35,
      color: Color(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 0.05,
      ),
    );

    renderer.circle(
      x: 740,
      y: 100,
      radius: 45,
      color: Color(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 0.02,
      ),
    );

    _train();

    // Background building 1
    renderer.rect(
      x: 0,
      y: 200,
      width: 220,
      height: 500,
      color: hexToColor('#1c0610'),
    );

    // Background building 2
    renderer.rect(
      x: 325,
      y: 200,
      width: 220,
      height: 220,
      color: hexToColor('#0e0e1b'),
    );

    // Window
    renderer.rect(
      x: 350,
      y: 250,
      width: 16,
      height: 32,
      color: hexToColor('#cccccc'),
    );

    // Middleground building 1
    renderer.rect(
      x: 0,
      y: 250,
      width: 270,
      height: 500,
      color: hexToColor('#1f1a17'),
    );

    renderer.rect(
      x: 0,
      y: 380,
      width: 270,
      height: 200,
      color: hexToColor('#15120f'),
    );

    // Middleground building 2
    renderer.rect(
      x: 500,
      y: 300,
      width: 350,
      height: 120,
      color: hexToColor('#16162a'),
    );
  }

  void _renderFishOnTheLine() {
    if (_fishOnTheLine) {
      if (_fishZoneLeft) {
        _currentFishZone += _currentFishZoneSpeed;
      } else {
        _currentFishZone -= _currentFishZoneSpeed;
      }

      if (_currentFishZone >= 160) {
        _fishZoneLeft = false;
      } else if (_currentFishZone <= 0) {
        _fishZoneLeft = true;
      }

      _renderer.rect(
        x: 300,
        y: 250,
        width: 180,
        height: 32,
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      );

      _renderer.rect(
        x: 302,
        y: 252,
        width: 176,
        height: 28,
        color: Color(
          red: 0,
          green: 0,
          blue: 0,
        ),
      );

      // hit zone
      _renderer.rect(
        x: 302 + _fishZone,
        y: 252,
        width: 24,
        height: 28,
        color: Color(
          red: 0,
          green: 255,
          blue: 0,
        ),
      );

      // pull point
      _renderer.rect(
        x: 302 + _currentFishZone,
        y: 252,
        width: 16,
        height: 28,
        color: Color(
          red: 255,
          green: 0,
          blue: 255,
        ),
      );

      // fish
      _renderer.renderImage(
        image: ImageElement(src: 'assets/images/fish.png'),
        x: 302 + _fishTimer,
        y: 235,
        width: 64,
        height: 64,
      );

      if (_fishTimer > 120) {
        _fishOnTheLine = false;
        _lastFishCaught = DateTime.now().millisecondsSinceEpoch;
      }

      _fishTimer += 0.5 + (_currentFishZoneSpeed / 10);
    }
  }

  void _renderParticle(
    List<Particle> particles,
  ) {
    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];

      renderer.rect(
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

      if (particle.lifeSpan <= 0 || particle.y > 800) {
        particles[i] = _refreshRainParticle();
      }
    }
  }

  @override
  void renderLoop() {
    // Background color
    renderer.rect(
      x: 0,
      y: 100,
      width: 800,
      height: 320,
      color: hexToColor('#1b1b37'),
    );

    _renderParticle(_backgroundRainParticles);
    _backgroundBuildings();

    // sit building ledge
    renderer.rect(
      x: 40,
      y: 420,
      width: 800,
      height: 320,
      color: hexToColor('#111111'),
    );

    // sit building
    renderer.rect(
      x: 40,
      y: 430,
      width: 800,
      height: 320,
      color: hexToColor('#000000'),
    );

    _dog.render();
    _hacker.render();
    _robot.render(_fishOnTheLine);

    for (int i = 0; i < 800; i += 256) {
      _lightPost.render(x: i + 240, y: 295, width: 60, height: 128);

      if (getRandomBetween(1, 10) < 4) {
        _lightPost.nextFrame();
      }
    }

    _animatedDoodads();

    _water();

    _renderParticle(_foregroundRainParticles);

    _renderFishOnTheLine();

    // Letterbox Top
    renderer.rect(
      x: 0,
      y: 0,
      width: 800,
      height: 100,
      color: hexToColor('#000000'),
    );

    // Letterbox Bottom
    renderer.rect(
      x: 0,
      y: 550,
      width: 800,
      height: 100,
      color: hexToColor('#000000'),
    );
  }

  void _water() {
    if (_waterRise) {
      _waterLevel += 0.05;
    } else {
      _waterLevel -= 0.05;
    }

    if (_waterLevel > 5) {
      _waterRise = false;
    } else if (_waterLevel < 0) {
      _waterRise = true;
    }

    renderer.rect(
      x: 0,
      y: 500 - _waterLevel,
      width: 800,
      height: 100,
      color: hexToColor('#0a141e'),
    );

    renderer.rect(
      x: 0,
      y: 500 - _waterLevel,
      width: 800,
      height: 10,
      color: hexToColor('#102030'),
    );

    for (int i = 0; i < 600; i += 150) {
      renderer.rect(
        x: 200 + i,
        y: 400,
        width: 25,
        height: 80,
        color: hexToColor('#000000'),
      );

      renderer.rect(
        x: 198 + i,
        y: 500 - _waterLevel,
        width: 32 - _waterLevel,
        height: 3,
        color: hexToColor('#3a4b5c'),
      );
    }

    _buoy.render(x: 500, y: 360 - _waterLevel, width: 128, height: 256);
    _seagull.render(x: 535, y: 360 - _waterLevel, width: 64, height: 96);
  }

  void _animatedDoodads() {
    renderer.rect(
      x: 48,
      y: 110,
      width: 120,
      height: 120,
      color: hexToColor('#000000'),
    );
    _neonSign.render(
      x: 50,
      y: 110,
      width: 100,
      height: 100,
    );

    _trash.render(x: 600, y: 350, width: 32, height: 80);
  }
}
