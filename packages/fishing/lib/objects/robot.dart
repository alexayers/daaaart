import 'dart:html';

import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/rendering/animation_bouncer.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class Robot {
  final _renderer = Renderer();

  final AnimatedSprite robotBody = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/robotBody.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite robotHead = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/robotHead.png',
      ],
      'blink': [
        'assets/images/robotHeadBlink.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite robotLegs = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/robotLegs.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite robotArms = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/robotArms.png',
      ],
    },
    currentAction: 'default',
  );

  final AnimatedSprite fishingRod = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/fishingRod.png',
      ],
    },
    currentAction: 'default',
  );

  final num _x = 350;
  final num _y = 330;
  num fishPull = 0;
  bool fishPushLeft = true;

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

  int blinkCounter = 0;

  void render(bool fishOnTheLine) {
    robotBody.render(x: _x, y: _y, width: 64, height: 128);

    final legBounce = _legBounce.bounce();
    robotLegs.render(x: _x, y: _y + legBounce, width: 64, height: 128);

    final typeCounter = _typeBounce.bounce();

    robotArms.render(
      x: _x + (fishPull / 50),
      y: _y + typeCounter + (fishPull / 25),
      width: 64,
      height: 128,
    );
    fishingRod.render(
      x: _x + (fishPull / 50),
      y: _y + typeCounter + (fishPull / 25),
      width: 64,
      height: 128,
    );

    blinkCounter++;

    if (blinkCounter >= 250 && blinkCounter <= 255) {
      robotHead.currentAction = 'blink';

      if (blinkCounter == 255) {
        blinkCounter = 0;
      }
    } else {
      robotHead.currentAction = 'default';
    }

    final hairBlowing = _hairBounce.bounce();

    if (fishOnTheLine) {
      _renderer.renderImage(
        image: ImageElement(src: 'assets/images/fishOnLine.png'),
        x: _x - hairBlowing + (fishPull / 75),
        y: _y - hairBlowing + (fishPull / 75) - 5,
        width: 64 + (fishPull / 25),
        height: 128 + (fishPull / 25),
      );
    }

    robotHead.render(
      x: _x - hairBlowing + (fishPull / 75),
      y: _y - hairBlowing + (fishPull / 75),
      width: 64 - hairBlowing + (fishPull / 75),
      height: 128 - hairBlowing + (fishPull / 75),
    );

    if (fishOnTheLine) {
      if (fishPushLeft) {
        fishPull += 2;
      } else {
        fishPull -= 2;
      }

      if (fishPull >= 100) {
        fishPushLeft = false;
      } else if (fishPull <= -100) {
        fishPushLeft = true;
      }
    }

    _renderer.line(
      x1: _x + 64,
      y1: _y + 52 + fishPull / 50,
      x2: _x + 64 + 50 + fishPull,
      y2: _y + 128 + 100 + 50 + fishPull,
      width: 2,
      color: Color(
        red: 255,
        green: 255,
        blue: 255,
      ),
    );
  }
}
