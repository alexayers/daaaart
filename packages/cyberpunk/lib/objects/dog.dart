import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class Dog {
  final AnimatedSprite _dog = AnimatedSprite(
    imageFiles: {
      'default': [
        'assets/images/dog1.png',
        'assets/images/dog2.png',
        'assets/images/dog3.png',
        'assets/images/dog2.png',
      ],
      'sit': [
        'assets/images/dogSit1.png',
        'assets/images/dogSit2.png',
        'assets/images/dogSit3.png',
        'assets/images/dogSit2.png',
      ],
    },
    currentAction: 'default',
  );

  num _x = 250;
  final num _y = 350;
  bool _sitting = false;
  num _lastSit = 0;
  bool _left = false;

  void render() {
    _dog.render(x: _x, y: _y, width: 70, height: 70, flip: _left);

    if (_sitting) {
      if (_lastSit == 0) {
        _lastSit = DateTime.now().millisecondsSinceEpoch;
      }

      if (DateTime.now().millisecondsSinceEpoch - _lastSit > 5000) {
        _sitting = false;
        _lastSit = DateTime.now().millisecondsSinceEpoch;
        _dog.currentAction = 'default';
      }
    } else {
      if (_left) {
        _x -= 1;
      } else {
        _x += 1;
      }
    }

    if (_x > 800) {
      _left = true;
    } else if (_x < 120) {
      _left = false;
    }

    if (getRandomBetween(1, 100) < 2 &&
        DateTime.now().millisecondsSinceEpoch - _lastSit > 30000) {
      _sitting = true;
      _dog.currentAction = 'sit';
    }
  }
}
