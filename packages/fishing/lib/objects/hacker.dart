import 'package:teenytinytwodee/rendering/animated_sprite.dart';

class Hacker {
  final AnimatedSprite hackerBody = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerBody.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite laptop = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/laptop.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite hackerHead = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerHead.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite hackerLeftLeg = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerLeftLeg.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite hackerRightLeg = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerRightLeg.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite hackerArms = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerArms.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite hackerHair = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/hackerHair.png',
      ],
    },
    currentAction: 'default',
  );

  final num _x = 50;
  final num _y = 330;

  num hairBlowing = 0;
  bool hairBlowingUp = true;

  int headTurnCounter = 0;
  bool headTurnRight = true;

  num legBounce = 0;
  bool legBounceUp = true;

  num typeCounter = 0;
  bool typeUp = true;

  void render() {
    hackerBody.render(x: _x, y: _y, width: 64, height: 128);

    hackerRightLeg.render(x: _x, y: _y, width: 64, height: 128);
    hackerLeftLeg.render(x: _x, y: _y + legBounce, width: 64, height: 128);

    if (legBounceUp) {
      legBounce += 0.01;
    } else {
      legBounce -= 0.01;
    }

    if (legBounce >= 1) {
      legBounceUp = false;
    } else if (legBounce <= 0) {
      legBounceUp = true;
    }

    hackerArms.render(x: _x, y: _y + typeCounter, width: 64, height: 128);

    if (typeUp) {
      typeCounter += 0.02;
    } else {
      typeCounter -= 0.02;
    }

    if (typeCounter >= 1) {
      typeUp = false;
    } else if (typeCounter <= 0) {
      typeUp = true;
    }

    laptop.render(x: _x, y: _y, width: 64, height: 128);

    hackerHead.render(
      x: _x - hairBlowing,
      y: _y - hairBlowing,
      width: 64 - hairBlowing,
      height: 128 - hairBlowing,
    );

    hackerHair.render(
      x: _x - hairBlowing,
      y: _y - hairBlowing,
      width: 64 - hairBlowing,
      height: 128 - hairBlowing,
    );

    if (hairBlowingUp) {
      hairBlowing += 0.012;
    } else {
      hairBlowing -= 0.012;
    }

    if (hairBlowing >= 0.9) {
      hairBlowingUp = false;
    } else if (hairBlowing <= 0) {
      hairBlowingUp = true;
    }
  }
}
