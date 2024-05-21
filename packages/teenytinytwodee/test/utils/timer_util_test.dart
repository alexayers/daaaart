import 'dart:io';

import 'package:teenytinytwodee/utils/timer_util.dart';
import 'package:test/test.dart';

void main() {
  group('TimerUtil', () {
    test('start should set the start time and wait time', () {
      final timerUtil = TimerUtil(1000);
      timerUtil.start();
      expect(timerUtil.startTime, isNot(0));
      expect(timerUtil.waitTime, 1000);
    });

    test('reset should update the start time', () {
      final timerUtil = TimerUtil(1000);
      timerUtil.start();
      timerUtil.reset();
      expect(timerUtil.startTime, isNot(0));
    });

    test('hasTimePassed should return true when enough time has passed', () {
      final timerUtil = TimerUtil(1);
      timerUtil.start();
      sleep(const Duration(milliseconds: 2));
      expect(timerUtil.hasTimePassed(), isTrue);
    });

    test('hasTimePassed should return false when not enough time has passed',
        () {
      final timerUtil = TimerUtil(10000);
      timerUtil.start();
      expect(timerUtil.hasTimePassed(), isFalse);
    });
  });
}
