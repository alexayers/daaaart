import 'dart:math';

import 'package:teenytinytwodee/utils/math_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Vector2', () {
    test('normalize', () {
      final vector = Vector2(3, 4);
      final normalized = vector.normalize();
      expect(normalized.x, closeTo(0.6, 0.001));
      expect(normalized.y, closeTo(0.8, 0.001));
    });

    test('angle', () {
      final vector = Vector2(3, 4);
      expect(vector.angle, closeTo(0.927, 0.001));
    });

    test('dot', () {
      final vector1 = Vector2(3, 4);
      final vector2 = Vector2(5, 6);
      final dotProduct = vector1.dot(vector2);
      expect(dotProduct, equals(39));
    });
  });

  group('getDecimal', () {
    test('positive number', () {
      final decimal = getDecimal(3.14);
      expect(decimal, closeTo(0.14, 0.001));
    });
  });

  group('isPointWithinQuad', () {
    test('point inside quad', () {
      const point = Point(3, 4);
      final isWithinQuad = isPointWithinQuad(
        point: point,
        x: 2,
        y: 3,
        width: 5,
        height: 6,
      );
      expect(isWithinQuad, isTrue);
    });

    test('point outside quad', () {
      const point = Point(70, 80);
      final isWithinQuad = isPointWithinQuad(
        point: point,
        x: 2,
        y: 3,
        width: 5,
        height: 6,
      );
      expect(isWithinQuad, isFalse);
    });
  });

  group('getRandomInt', () {
    test('random int within range', () {
      final randomInt = getRandomInt(10);
      expect(randomInt, isNonNegative);
      expect(randomInt, lessThanOrEqualTo(10));
    });
  });

  group('getRandomBetween', () {
    test('random number within range', () {
      final randomNum = getRandomBetween(5, 10);
      expect(randomNum, isNonNegative);
      expect(randomNum, greaterThanOrEqualTo(5));
      expect(randomNum, lessThanOrEqualTo(10));
    });
  });

  group('getRandomArrayElement', () {
    test('random element from array', () {
      final array = [1, 2, 3, 4, 5];
      final randomElement = getRandomArrayElement(array);
      expect(array.contains(randomElement), isTrue);
    });
  });

  group('distanceBetweenTwoPixelCoords', () {
    test('distance between two points', () {
      final distance = distanceBetweenTwoPixelCoords(
        x1: 3,
        y1: 4,
        x2: 6,
        y2: 8,
      );
      expect(distance, closeTo(5, 0.001));
    });
  });

  group('calculateXPercentOfY', () {
    test('calculate percentage', () {
      final result = calculateXPercentOfY(20, 100);
      expect(result, equals(20));
    });
  });

  group('calculatePercent', () {
    test('calculate percentage', () {
      final result = calculatePercent(50, 200);
      expect(result, equals(25));
    });
  });
}
