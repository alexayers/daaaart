class TimerUtil {
  int _startTime = 0;
  int waitTime = 0;

  int get startTime => _startTime;

  void start() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  void reset() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  bool hasTimePassed() {
    return _startTime + waitTime < DateTime.now().millisecondsSinceEpoch;
  }
}
