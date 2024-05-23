import 'dart:html';

import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/gui/window_widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class WidgetManager {
  final List<Widget> _widgets = [];

  void addWidget(Widget widget) {
    _widgets.add(widget);
  }

  void addAllWidgets(List<Widget> widgets) {
    _widgets.addAll(widgets);
  }

  void removeWidget(Widget widget) {
    _widgets.remove(widget);
  }

  void render(num offsetX, num offsetY) {
    for (final Widget widget in _widgets) {
      widget.render(offsetX, offsetY);
    }
  }

  void mouseClick(num x, num y, MouseButton mouseButton) {
    for (final Widget widget in _widgets) {
      if (isPointWithinQuad(
        Point(x, y),
        widget.x,
        widget.y,
        widget.width,
        widget.height,
      )) {
        widget.mouseClick(x, y, mouseButton);
      }
    }
  }

  void mouseOver(num x, num y) {
    for (final Widget widget in _widgets) {
      if (isPointWithinQuad(
        Point(x, y),
        widget.x,
        widget.y,
        widget.width,
        widget.height,
      )) {
        if (widget is WindowWidget) {
          widget.mouseOver(x, y);
        } else {
          widget.isMouseOver = true;
        }
      }
    }
  }
}
