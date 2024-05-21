import 'package:teenytinytwodee/logger/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logger', () {
    test('should log info message', () {
      const logType = LogType.info;
      const msg = 'This is an info message';
      final expectedLog = '${DateTime.now().toIso8601String()} - INFO - $msg';

      expect(() => logger(logType, msg), prints(expectedLog));
    });

    test('should log error message', () {
      const logType = LogType.error;
      const msg = 'This is an error message';
      final expectedLog = '${DateTime.now().toIso8601String()} - ERROR - $msg';

      expect(() => logger(logType, msg), prints(expectedLog));
    });

    test('should log debug message', () {
      const logType = LogType.debug;
      const msg = 'This is a debug message';
      final expectedLog = '${DateTime.now().toIso8601String()} - DEBUG - $msg';

      expect(() => logger(logType, msg), prints(expectedLog));
    });
  });
}
