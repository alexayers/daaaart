class GameEvent {

  GameEvent(this._channel, this._payload);
  final String _channel;
  final dynamic _payload;

  String get channel => _channel;

  dynamic get payload => _payload;
}
