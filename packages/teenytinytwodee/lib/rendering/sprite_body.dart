import 'package:teenytinytwodee/rendering/animated_sprite.dart';

class SpriteBody {
  SpriteBody({
    AnimatedSprite? body,
    AnimatedSprite? head,
    AnimatedSprite? hair,
    AnimatedSprite? arms,
    AnimatedSprite? leftArm,
    AnimatedSprite? rightArm,
    AnimatedSprite? legs,
    AnimatedSprite? rightLeg,
    AnimatedSprite? leftLeg,
  })  : _body = body,
        _head = head,
        _hair = hair,
        _arms = arms,
        _leftArm = leftArm,
        _rightArm = rightArm,
        _legs = legs,
        _rightLeg = rightLeg,
        _leftLeg = leftLeg;
  final AnimatedSprite? _body;
  final AnimatedSprite? _head;
  final AnimatedSprite? _hair;
  final AnimatedSprite? _arms;
  final AnimatedSprite? _leftArm;
  final AnimatedSprite? _rightArm;
  final AnimatedSprite? _legs;
  final AnimatedSprite? _rightLeg;
  final AnimatedSprite? _leftLeg;

  void render({
    required num x,
    required num y,
    required num width,
    required num height,
  }) {
    if (_body != null) {
      _body.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_head != null) {
      _head.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_hair != null) {
      _hair.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_arms != null) {
      _arms.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }
    if (_leftArm != null) {
      _leftArm.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_rightArm != null) {
      _rightArm.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }
    if (_legs != null) {
      _legs.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_rightLeg != null) {
      _rightLeg.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }

    if (_leftLeg != null) {
      _leftLeg.render(
        x: x,
        y: y,
        width: width,
        height: height,
      );
    }
  }
}
