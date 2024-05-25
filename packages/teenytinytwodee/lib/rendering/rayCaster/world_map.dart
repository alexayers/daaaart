import 'package:teenytinytwodee/ecs/components/door_component.dart';
import 'package:teenytinytwodee/ecs/components/push_wall_component.dart';
import 'package:teenytinytwodee/ecs/game_entity.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/rayCaster/render_performance.dart';
import 'package:teenytinytwodee/rendering/sprite.dart';

enum DoorState { closed, opening, open, closing }

class WorldDefinition {
  late List<int> grid;
  late List<GameEntity> items = [];
  late List<GameEntity> npcs = [];
  late Sprite? skyBox;
  late Color skyColor;
  late Color floorColor;
  late Map<int, GameEntity> translationTable;
  late num lightRange;
  late int width;
  late int height;
}

class WorldMap {
  factory WorldMap() {
    return _instance;
  }
  WorldMap._privateConstructor();

  static final WorldMap _instance = WorldMap._privateConstructor();

  late final List<GameEntity> _gameMap = [];
  late int _worldWidth;
  late int _worldHeight;
  final Logger _logger = Logger();
  final List<num> _doorOffsets = [];
  final List<DoorState> _doorStates = [];
  late WorldDefinition worldDefinition;
  bool worldLoaded = false;
  final RenderPerformance _renderPerformance = RenderPerformance();

  void loadMap(WorldDefinition worldDefinition) {
    this.worldDefinition = worldDefinition;
    _worldWidth = worldDefinition.width;
    _worldHeight = worldDefinition.height;

    for (int y = 0; y < _worldHeight; y++) {
      for (int x = 0; x < _worldWidth; x++) {
        final int pos = x + (y * _worldWidth);
        final int value = worldDefinition.grid[pos];
        _gameMap.add(worldDefinition.translationTable[value]!);
      }
    }

    for (int i = 0; i < _worldWidth * _worldHeight; i++) {
      _doorOffsets.add(0);
      _doorStates.add(DoorState.closed);
    }

    worldLoaded = true;
    _logger.info('The map has been loaded.');
  }

  void moveDoors() {
    if (!worldLoaded) {
      return;
    }

    for (int y = 0; y < _worldHeight; y++) {
      for (int x = 0; x < _worldWidth; x++) {
        final GameEntity gameEntity = getEntityAtPosition(x, y);

        if (gameEntity.hasComponent('door')) {
          //Standard door
          if (getDoorState(x, y) == DoorState.opening) {
            //Open doors
            setDoorOffset(
              x,
              y,
              getDoorOffset(x, y) + _renderPerformance.deltaTime / 100,
            );

            if (getDoorOffset(x, y) > 1) {
              setDoorOffset(x, y, 1);
              setDoorState(x, y, DoorState.open); //Set state to open

              final DoorComponent door =
                  gameEntity.getComponent('door')! as DoorComponent;
              door.openDoor();

              Future.delayed(const Duration(seconds: 5), () {
                setDoorState(x, y, DoorState.closing);

                final door = gameEntity.getComponent('door')! as DoorComponent;
                door.closeDoor();
              });
            }
          } else if (getDoorState(x, y) == DoorState.closing) {
            setDoorOffset(
              x,
              y,
              getDoorOffset(x, y) - _renderPerformance.deltaTime / 100,
            );

            if (getDoorOffset(x, y) < 0) {
              setDoorOffset(x, y, 0);
              setDoorState(x, y, DoorState.closed);

              final DoorComponent door =
                  gameEntity.getComponent('door')! as DoorComponent;
              door.closeDoor();
            }
          }
        } else if (gameEntity.hasComponent('pushWall')) {
          if (getDoorState(x, y) == DoorState.opening) {
            setDoorOffset(
              x,
              y,
              getDoorOffset(x, y) + _renderPerformance.deltaTime / 100,
            );

            if (getDoorOffset(x, y) > 2) {
              setDoorOffset(x, y, 2);
              setDoorState(x, y, DoorState.open);

              final PushWallComponent pushWall =
                  gameEntity.getComponent('pushWall')! as PushWallComponent;
              pushWall.openWall();
            }
          }
        }
      }
    }
  }

  List<GameEntity> getWorldItems() {
    return worldDefinition.items;
  }

  List<GameEntity> getWorldNpcs() {
    return worldDefinition.npcs;
  }

  void removeWorldItem(GameEntity gameEntity) {
    int index = -1;
    for (int i = 0; i < worldDefinition.items.length; i++) {
      if (gameEntity.id == worldDefinition.items[i].id) {
        index = i;
      }
    }

    if (index > -1) {
      worldDefinition.items.removeAt(index);
    }
  }

  void removeWorldNpc(GameEntity gameEntity) {
    int index = -1;
    for (int i = 0; i < worldDefinition.npcs.length; i++) {
      if (gameEntity.id == worldDefinition.npcs[i].id) {
        index = i;
      }
    }

    if (index > -1) {
      worldDefinition.npcs.removeAt(index);
    }
  }

  GameEntity getEntityAtPosition(int x, int y) {
    return _gameMap[x + (y * _worldWidth)];
  }

  DoorState getDoorState(int x, int y) {
    return _doorStates[x + (y * _worldWidth)];
  }

  num getDoorOffset(int x, int y) {
    return _doorOffsets[x + (y * _worldWidth)];
  }

  void setDoorState(int x, int y, DoorState state) {
    _doorStates[x + (y * _worldWidth)] = state;
  }

  void setDoorOffset(int x, int y, num offset) {
    _doorOffsets[x + (y * _worldWidth)] = offset;
  }

  List<GameEntity> get gameMap => _gameMap;
}
