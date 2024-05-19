class GlobalState {
  factory GlobalState() {
    return _instance;
  }

  GlobalState._privateConstructor();
  static final GlobalState _instance = GlobalState._privateConstructor();

  static final Map<String, dynamic> _globalState = {};

  static void createState(String key, dynamic value) {
    _globalState[key] = value;
  }

  static dynamic getState(String key) {
    return _globalState[key];
  }

  static bool hasState(String key) {
    return _globalState.containsKey(key);
  }

  static void removeWhere(String partialKey) {
    _globalState.removeWhere((key, value) => key.startsWith(partialKey));
  }
}
