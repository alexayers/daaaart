import 'package:teenytinytwodee/ecs/game_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';

class InventoryComponent implements GameComponent {
  InventoryComponent(this.maxItems) {
    for (int i = 0; i < maxItems; i++) {
      _inventory.add(null);
    }
  }
  final List<GameEntity?> _inventory = [];
  int maxItems = 6;
  int currentItemIdx = 0;

  GameEntity? getCurrentItem() {
    return _inventory[currentItemIdx];
  }

  void dropItem() {
    if (currentItemIdx > -1) {
      _inventory[currentItemIdx] = null;
    }
  }

  bool addItem(GameEntity item) {
    for (int i = 0; i < maxItems; i++) {
      if (_inventory[i] == null) {
        _inventory[i] = item;
        currentItemIdx = i;
        return true;
      }
    }

    return false;
  }

  List<GameEntity?> get inventory => _inventory;

  @override
  String get name => 'inventory';
}
