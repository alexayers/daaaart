class TimerUtil {
  TimerUtil(int waitTime) : _waitTime = waitTime;

  int _startTime = 0;
  final int _waitTime;

  int get startTime => _startTime;
  int get waitTime => _waitTime;

  void start() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  void reset() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  bool hasTimePassed() {
    return _startTime + _waitTime < DateTime.now().millisecondsSinceEpoch;
  }
}
