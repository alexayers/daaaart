class RenderPerformance {
  factory RenderPerformance() {
    return _instance;
  }
  RenderPerformance._privateConstructor();
  static final RenderPerformance _instance =
      RenderPerformance._privateConstructor();

  num _frameCount = 0;
  num _lastFrame = 0;
  num _frameTime = 0;
  num _deltaTime = 0;

  num get frameCount => _frameCount;
  num get frameTime => _frameTime;
  num get deltaTime => _deltaTime;

  void updateFrameTimes() {
    _frameCount++;
    _frameTime = DateTime.now().millisecondsSinceEpoch - _lastFrame;
    _deltaTime = _frameTime / (1000 / 60);
    _lastFrame = DateTime.now().millisecondsSinceEpoch;
  }
}
