import 'package:teenytinytwodee/application/global_state.dart';
import 'package:test/test.dart';

void main() {
  group('Global State Tests', () {
    test('Create State', () {
      GlobalState.createState('testKey', 'testValue');
      expect(GlobalState.getState('testKey'), 'testValue');
    });

    test('Get State', () {
      GlobalState.createState('testKey', 'testValue');
      expect(GlobalState.getState('testKey'), 'testValue');
    });

    test('Has State', () {
      GlobalState.createState('testKey', 'testValue');
      expect(GlobalState.hasState('testKey'), isTrue);
    });

    test('Remove Where', () {
      GlobalState.createState('testKey1', 'testValue1');
      GlobalState.createState('testKey2', 'testValue2');
      GlobalState.createState('otherKey', 'otherValue');
      GlobalState.removeWhere('test');
      expect(GlobalState.hasState('testKey1'), isFalse);
      expect(GlobalState.hasState('testKey2'), isFalse);
      expect(GlobalState.hasState('otherKey'), isTrue);
    });
  });
}
