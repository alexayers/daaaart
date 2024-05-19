class GlobalLogic {
  final List<void Function()> _globalCallbacks = [];

  void registerLogic(void Function() function) {
    _globalCallbacks.add(function);
  }

  void execute() {
    for (final callback in _globalCallbacks) {
      callback();
    }
  }
}
