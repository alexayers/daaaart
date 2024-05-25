// ignore_for_file: avoid_print

enum LogType { info, debug, error }

class Logger {
  factory Logger() {
    return _instance;
  }

  Logger._internal();

  static final Logger _instance = Logger._internal();

  void info(String msg) {
    final date = DateTime.now();
    final dateString = date.toIso8601String();

    print('$dateString - INFO - $msg');
  }

  void error(String msg) {
    final date = DateTime.now();
    final dateString = date.toIso8601String();

    print('$dateString - ERROR - $msg');
  }

  void debug(String msg) {
    final date = DateTime.now();
    final dateString = date.toIso8601String();

    print('$dateString - DEBUG - $msg');
  }
}
