import 'dart:html';
import 'dart:math';

import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/primitives/rect.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';

class Renderer {
  factory Renderer() {
    return _instance;
  }
  Renderer._privateConstructor() {
    final container = DivElement();
    container.id = 'container';

    _canvas = CanvasElement(width: 800, height: 600);
    _canvas.id = 'game';
    container.append(_canvas);

    document.body?.append(container);

    _ctx = _canvas.getContext('2d')! as CanvasRenderingContext2D;
    _ctx.imageSmoothingEnabled = false;

    _calculationCanvas = CanvasElement();
    _calculationCanvasCtx =
        _calculationCanvas.getContext('2d')! as CanvasRenderingContext2D;

    disabledImageSmoothing();
  }

  static final Renderer _instance = Renderer._privateConstructor();

  late CanvasElement _canvas;
  late CanvasRenderingContext2D _ctx;
  late CanvasElement _calculationCanvas;
  late CanvasRenderingContext2D _calculationCanvasCtx;

  void clearScreen() {
    _ctx.clearRect(0, 0, _canvas.width! as num, _canvas.height! as num);
  }

  void setColor(Color color) {
    _ctx.fillStyle = rbgToHex(color.red, color.green, color.blue);
  }

  void resize() {
    _canvas.width = window.innerWidth;
    _canvas.height = window.innerHeight;
    _ctx.imageSmoothingEnabled = false;
  }

  void renderImage({
    required ImageElement image,
    required num x,
    required num y,
    required num width,
    required num height,
    bool flip = false,
  }) {
    if (flip) {
      _ctx.translate(x + width, y);
      _ctx.scale(-1, 1);

      _ctx.drawImageScaled(image, 0, 0, width, height);

      _ctx.setTransform(1, 0, 0, 1, 0, 0);
    } else {
      _ctx.drawImageScaled(image, x, y, width, height);
    }
  }

  void renderClippedImage({
    required ImageElement image,
    required num sourceX,
    required num sourceY,
    required num sourceWidth,
    required num sourceHeight,
    required num destX,
    required num destY,
    required num destWidth,
    required num destHeight,
  }) {
    _ctx.drawImageScaledFromSource(
      image,
      sourceX,
      sourceY,
      sourceWidth,
      sourceHeight,
      destX,
      destY,
      destWidth,
      destHeight,
    );
  }

  num calculateTextWidth(String text, String font) {
    _calculationCanvasCtx.font = font;
    final TextMetrics metrics = _calculationCanvasCtx.measureText(text);
    return metrics.width!;
  }

  void print({
    required String msg,
    required num x,
    required num y,
    required Font font,
  }) {
    _ctx.font = '${font.size}px ${font.family}';
    _ctx.fillStyle =
        rbgToHex(font.color.red, font.color.green, font.color.blue);
    _ctx.globalAlpha = font.color.alpha;
    _ctx.fillText(msg, x, y);
    _ctx.globalAlpha = 1;
  }

  List<String> getLines(String text, int maxWidth) {
    final List<String> words = text.split(' ');
    final List<String> lines = [];
    String currentLine = words[0];

    for (int i = 1; i < words.length; i++) {
      final String word = words[i];
      final num? width = _ctx.measureText('$currentLine $word').width;
      if (width! < maxWidth) {
        currentLine += ' $word';
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }

    lines.add(currentLine);
    return lines;
  }

  void fillAndClose() {
    _ctx.fill();
    _ctx.closePath();
  }

  void beginPath() {
    _ctx.beginPath();
  }

  void circle({
    required num x,
    required num y,
    required num radius,
    required Color color,
  }) {
    _ctx.beginPath();

    setColor(color);
    alpha = color.alpha;

    _ctx.arc(x, y, radius, 0, 2 * pi);

    _ctx.fill();
    _ctx.closePath();

    alpha = 1;
  }

  void line({
    required num x1,
    required num y1,
    required num x2,
    required num y2,
    required num width,
    required Color color,
  }) {
    _ctx.beginPath();

    _ctx.moveTo(x1, y1);
    _ctx.lineTo(x2, y2);
    _ctx.lineWidth = width;
    _ctx.strokeStyle = rbgToHex(color.red, color.green, color.blue);
    alpha = color.alpha;
    _ctx.stroke();
  }

  void batchRect(List<Rect> rectangles, Color color) {
    _ctx.beginPath();

    setColor(color);
    alpha = color.alpha;

    for (final rect in rectangles) {
      _ctx.rect(rect.x, rect.y, rect.width, rect.height);
    }

    _ctx.fill();
    _ctx.closePath();
    alpha = 1;
  }

  void rectGradient({
    required num x,
    required num y,
    required num width,
    required num height,
    required String startColor,
    required String endColor,
  }) {
    final num midY = getCanvasHeight() / 2;
    final num height = getCanvasHeight();

    // Create a vertical linear gradient
    final gradient = _ctx.createLinearGradient(0, midY, 0, height);
    gradient.addColorStop(0, startColor);
    gradient.addColorStop(1, endColor);

    // Use the gradient to fill the rectangle
    _ctx.fillStyle = gradient;
    _ctx.fillRect(0, midY, getCanvasWidth(), height);
  }

  void rect({
    required num x,
    required num y,
    required num width,
    required num height,
    required Color color,
  }) {
    _ctx.beginPath();

    setColor(color);
    alpha = color.alpha;

    _ctx.rect(x, y, width, height);

    _ctx.fill();
    _ctx.closePath();
    alpha = 1;
  }

  set alpha(num alpha) {
    _ctx.globalAlpha = alpha;
  }

  num get alpha => _ctx.globalAlpha;

  int getCanvasWidth() {
    return _canvas.width!;
  }

  int getCanvasHeight() {
    return _canvas.height!;
  }

  void saveContext() {
    _ctx.save();
  }

  void restoreContext() {
    _ctx.restore();
  }

  void enableImageSmoothing() {
    _ctx.imageSmoothingEnabled = true;
  }

  void disabledImageSmoothing() {
    _ctx.imageSmoothingEnabled = false;
  }

  void translate(num x, num y) {
    _ctx.translate(x, y);
  }

  void rotate(num angle) {
    _ctx.rotate(-(angle - pi * 0.5));
  }

  CanvasRenderingContext2D getContext() {
    return _ctx;
  }

  Rectangle<num> getBoundingClientRect() {
    return _canvas.getBoundingClientRect();
  }
}
