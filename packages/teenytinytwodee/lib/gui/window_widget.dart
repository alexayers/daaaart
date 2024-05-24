import 'dart:math';

import 'package:teenytinytwodee/gui/dial_widget.dart';
import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';

class WindowWidget extends Widget {
  WindowWidget({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
  });

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

  @override
  void render(num offsetX, num offsetY) {
    for (final Widget widget in _widgets) {
      widget.render(offsetX + x, offsetY + y);
    }
  }

  @override
  void mouseClick(num x, num y, MouseButton mouseButton) {
    for (final Widget widget in _widgets) {
      if (widget is DialWidget &&
              isPointWithinCircle(
                point: Point(x, y),
                cx: widget.x + super.x,
                cy: widget.y + super.y,
                radius: widget.radius,
              ) ||
          isPointWithinQuad(
            point: Point(x, y),
            x: widget.x + super.x,
            y: widget.y + super.y,
            width: widget.width,
            height: widget.height,
          )) {
        widget.onClick?.call();
      }
    }
  }

  @override
  void mouseOver(num x, num y) {
    for (final Widget widget in _widgets) {
      if (widget is DialWidget &&
              isPointWithinCircle(
                point: Point(x, y),
                cx: widget.x + super.x,
                cy: widget.y + super.y,
                radius: widget.radius,
              ) ||
          isPointWithinQuad(
            point: Point(x, y),
            x: widget.x + super.x,
            y: widget.y + super.y,
            width: widget.width,
            height: widget.height,
          )) {
        widget.isMouseOver = true;
      } else {
        widget.isMouseOver = false;
      }
    }
  }
}
