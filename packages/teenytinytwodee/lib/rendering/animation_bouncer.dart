class AnimationBounce {
  AnimationBounce({
    required num increaseBy,
    required num until,
  })  : _increaseBy = increaseBy,
        _until = until;

  num _current = 0;
  bool _isIncreasing = true;

  final num _increaseBy;
  final num _until;

  num bounce() {
    if (_isIncreasing) {
      _current += _increaseBy;
    } else {
      _current -= _increaseBy;
    }

    if (_current >= _until) {
      _isIncreasing = false;
    } else if (_current <= 0) {
      _isIncreasing = true;
    }

    return _current;
  }
}
