import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/audio/wave_form_synthesis.dart';
import 'package:teenytinytwodee/gui/button_widget.dart';
import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/gui/window_widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';

class DrumMachineOverlay extends GameScreenOverlay {
  final _renderer = Renderer();
  final _wavFormSynthesis = WavFormSynthesis();

  @override
  void init() {
    _wavFormSynthesis.register(
      name: 'kick',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.5,
    );

    _wavFormSynthesis.register(
      name: 'snare',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.2,
      generateWhiteNoise: true,
    );

    _wavFormSynthesis.register(
      name: 'hihat',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.1,
      generateWhiteNoise: true,
    );

    _wavFormSynthesis.register(
      name: 'cymbal',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.5,
      generateWhiteNoise: true,
    );
  }

  @override
  void renderLoop() {
    _renderer.rect(
      x: 250,
      y: 120,
      width: 300,
      height: 300,
      color: black,
    );

    _renderer.rect(
      x: 252,
      y: 122,
      width: 296,
      height: 296,
      color: hexToColor('#201904'),
    );

    _renderer.rect(
      x: 262,
      y: 132,
      width: 276,
      height: 276,
      color: black,
    );
  }

  @override
  void keyboard(int keyCode) {
    // TODO: implement keyboard
  }

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {
    // TODO: implement mouseClick
  }

  @override
  void mouseMove(double x, double y) {
    // TODO: implement mouseMove
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onOpen() {
    // TODO: implement onOpen
  }

  @override
  void logicLoop() {
    // TODO: implement logicLoop
  }

  @override
  List<Widget> getWidgets() {
    final List<Widget> widgets = [];

    final windowWidget = WindowWidget(
      id: 'drumMachine',
      x: 262,
      y: 132,
      width: 276,
      height: 276,
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'drumMachine',
        x: 50,
        y: 10,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          logger(LogType.info, 'kick');
          _wavFormSynthesis.play('kick');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'drumMachine',
        x: 100,
        y: 10,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          logger(LogType.info, 'hihat');
          _wavFormSynthesis.play('hihat');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'drumMachine',
        x: 150,
        y: 10,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          logger(LogType.info, 'snare');
          _wavFormSynthesis.play('snare');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'drumMachine',
        x: 200,
        y: 10,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          logger(LogType.info, 'cymbal');
          _wavFormSynthesis.play('cymbal');
        },
      ),
    );

    widgets.add(windowWidget);

    return widgets;
  }
}