// ignore_for_file: avoid_print

enum LogType { info, debug, error }

void logger(LogType logType, String msg) {
  final date = DateTime.now();
  final dateString = date.toIso8601String();

  switch (logType) {
    case LogType.info:
      print('$dateString - INFO - $msg');
    case LogType.error:
      print('$dateString - ERROR - $msg');
    case LogType.debug:
      print('$dateString - DEBUG - $msg');
  }
}
