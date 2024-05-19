import 'package:teenytinytwodee/ecs/game_component.dart';

class CanInteractComponent implements GameComponent {
  CanInteractComponent([this.callBack]);
  void Function()? callBack;

  @override
  String get name => 'canInteract';
}
