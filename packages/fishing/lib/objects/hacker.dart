import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/rendering/animation_bouncer.dart';

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

  final _hairBounce = AnimationBounce(
    increaseBy: 0.012,
    until: 0.9,
  );

  final _typeBounce = AnimationBounce(
    increaseBy: 0.02,
    until: 1,
  );

  final _legBounce = AnimationBounce(
    increaseBy: 0.01,
    until: 1,
  );

  int headTurnCounter = 0;
  bool headTurnRight = true;

  void render() {
    hackerBody.render(x: _x, y: _y, width: 64, height: 128);
    hackerRightLeg.render(x: _x, y: _y, width: 64, height: 128);

    final legBounce = _legBounce.bounce();
    hackerLeftLeg.render(x: _x, y: _y + legBounce, width: 64, height: 128);

    final typeCounter = _typeBounce.bounce();
    hackerArms.render(x: _x, y: _y + typeCounter, width: 64, height: 128);

    laptop.render(x: _x, y: _y, width: 64, height: 128);

    final hairBlowing = _hairBounce.bounce();

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
  }
}
