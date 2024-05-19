import 'dart:core';

import 'package:teenytinytwodee/rendering/rayCaster/world_map.dart';

class PathNode {
  PathNode(this.x, this.y);
  int x;
  int y;
  late int idx;
  late int parent;
  late int g;
  late int h;
  late int f;
}

class AStar {
  AStar(this._startX, this._startY, this._endX, this._endY) {
    final int idx = _translateCoordinatesToIdx(_startX, _startY);

    final PathNode n = PathNode(_startX, _startY);
    n.idx = idx;
    n.parent = 0;
    n.g = 0;
    n.h = _getManhattanDistance(n.x, n.y);
    n.f = n.g + n.h;

    _openSet[idx] = n;
  }
  final Map<int, PathNode> _closedSet = {};
  final Map<int, PathNode> _openSet = {};
  List<PathNode> path = [];
  PathNode _currentNode = PathNode(0, 0);

  final int _startX;
  final int _startY;
  final int _endX;
  final int _endY;
  final WorldMap _worldMap = WorldMap();

  int _translateCoordinatesToIdx(int x, int y) {
    return x + (y * _worldMap.worldDefinition.width);
  }

  int _getManhattanDistance(int x, int y) {
    return ((x - _endX).abs() + (y - _endY).abs()) * 10;
  }

  bool _isOnClosedList(int idx) {
    return _closedSet.containsKey(idx);
  }

  bool _isOnOpenedList(int idx) {
    return _openSet.containsKey(idx);
  }

  void _addToOpenedList(PathNode pathNode) {
    _openSet[pathNode.idx] = pathNode;
  }

  void _addToClosedList(PathNode pathNode) {
    _closedSet[pathNode.idx] = pathNode;
  }

  PathNode _findLowestCost() {
    int f = 99999;
    int lowestCostIdx = 0;

    for (final entry in _openSet.entries) {
      final PathNode pathNode = entry.value;

      if (pathNode.f <= f) {
        f = pathNode.f;
        lowestCostIdx = pathNode.idx;
      }
    }

    // Retrieve and remove the node with the lowest cost
    final PathNode lowestNode = _openSet[lowestCostIdx]!;
    _openSet.remove(lowestCostIdx);
    return lowestNode;
  }

  int _calculateGValue(int x, int y) {
    // Checking behind me
    if (x == (_currentNode.x - 1) && y == _currentNode.y) {
      final bool wall = _isWall(_currentNode.x - 1, _currentNode.y);
      return _getTileWeight(wall);
      // Checking in front of me
    } else if (x == (_currentNode.x + 1) && y == _currentNode.y) {
      final bool wall = _isWall(_currentNode.x + 1, _currentNode.y);
      return _getTileWeight(wall);
      // Checking above me
    } else if (x == (_currentNode.x) && y == _currentNode.y + 1) {
      final bool wall = _isWall(_currentNode.x, _currentNode.y + 1);
      return _getTileWeight(wall);
      // Checking below me
    } else if (x == (_currentNode.x) && y == _currentNode.y - 1) {
      final bool wall = _isWall(_currentNode.x, _currentNode.y - 1);
      return _getTileWeight(wall);
      // Checking diagonal
    } else {
      return 1400;
    }
  }

  int _getTileWeight(bool wall) {
    if (!wall) {
      return 10;
    } else {
      return 100000;
    }
  }

  void _buildNodeList() {
    for (int y = _currentNode.y + 1; y >= (_currentNode.y - 1); y--) {
      for (int x = _currentNode.x - 1; x < (_currentNode.x + 2); x++) {
        if (x == _currentNode.x && y == _currentNode.y) {
          continue;
        } else {
          if (y >= 0 &&
              x >= 0 &&
              x < (_worldMap.worldDefinition.width - 1) &&
              y < (_worldMap.worldDefinition.height - 1)) {
            final int cost = _currentNode.g + _calculateGValue(x, y);
            final int idx = _translateCoordinatesToIdx(x, y);

            if (_isOnOpenedList(idx) && cost < _openSet[idx]!.g) {
              _openSet[idx]!.g = cost;
              _openSet[idx]!.f = _openSet[idx]!.g + _openSet[idx]!.h;
              _openSet[idx]!.parent = _currentNode.idx;
            } else if (_isOnClosedList(idx)) {
              continue;
            } else if (!_isOnOpenedList(idx)) {
              final PathNode n = PathNode(0, 0);
              n.g = cost;
              n.x = x;
              n.y = y;
              n.h = _getManhattanDistance(x, y);
              n.idx = idx;
              n.parent = _currentNode.idx;
              n.f = n.g + n.h;
              _addToOpenedList(n);
            }
          }
        }
      }
    }
  }

  void _buildRoute() {
    final int startIdx = _translateCoordinatesToIdx(_startX, _startY);
    int idx = _translateCoordinatesToIdx(_endX, _endY);

    while (idx != startIdx) {
      path.add(_closedSet[idx]!);
      idx = _closedSet[idx]!.parent;
    }
  }

  bool isPathFound() {
    bool pathFound = false;

    while (_openSet.isNotEmpty) {
      _currentNode = _findLowestCost();
      _addToClosedList(_currentNode);

      if (_currentNode.idx == _translateCoordinatesToIdx(_endX, _endY)) {
        _buildRoute();

        pathFound = true;
        break;
      } else {
        _buildNodeList();
      }
    }

    path = path.reversed.toList();

    return pathFound;
  }

  bool _isWall(int x, int y) {
    final int pos = x + (y * _worldMap.worldDefinition.width);

    if (pos < 0 ||
        pos >=
            (_worldMap.worldDefinition.width *
                _worldMap.worldDefinition.height)) {
      return true;
    }

    return _worldMap.getEntityAtPosition(x, y).hasComponent('wall') ||
        _worldMap.getEntityAtPosition(x, y).hasComponent('transparent');
  }
}
