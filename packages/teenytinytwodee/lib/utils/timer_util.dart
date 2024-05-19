class TimerUtil {
  TimerUtil(int waitTime) {
    _waitTime = waitTime;
  }
  var _startTime = 0;

  var _waitTime = 0;

  void start(int waitTime) {
    _waitTime = _waitTime;
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  void reset() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  bool hasTimePassed() {
    return _startTime + _waitTime < DateTime.now().millisecondsSinceEpoch;
  }
}
