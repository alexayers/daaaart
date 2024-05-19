import 'package:teenytinytwodee/ecs/components/inventory_component.dart';
import 'package:teenytinytwodee/ecs/game_component.dart';

class SearchingComponent implements GameComponent {
  SearchingComponent(this.searching);
  InventoryComponent searching;

  @override
  String get name => 'searching';
}
