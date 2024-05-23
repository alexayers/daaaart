import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/audio/wave_form_synthesis.dart';
import 'package:teenytinytwodee/gui/button_widget.dart';
import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/gui/window_widget.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';
import 'package:teenytinytwodee/utils/timer_util.dart';

class DrumMachineOverlay extends GameScreenOverlay {
  final _renderer = Renderer();
  final _wavFormSynthesis = WavFormSynthesis();

  final _drumTrack = Map<String, List<int>>() = {
    'kick': [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
    'snare': [1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0],
    'cymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'rideCymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'hihat': [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    'lowTom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'midTom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'highTom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  };

  int _currentBar = 0;
  final TimerUtil _timer = TimerUtil(120);

  @override
  void init() {
    _wavFormSynthesis.register(
      name: 'kick',
      waveForm: WaveForm.sine,
      frequency: 50,
      duration: 0.5,
      volume: 1.0,
    );

    _wavFormSynthesis.register(
      name: 'triangle',
      waveForm: WaveForm.sine,
      frequency: 1200,
      duration: 0.5,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'lowToms',
      waveForm: WaveForm.sine,
      frequency: 100,
      duration: 0.5,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'midToms',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.5,
      volume: 1,
    );

    _wavFormSynthesis.register(
      name: 'highToms',
      waveForm: WaveForm.sine,
      frequency: 200,
      duration: 0.5,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'snare',
      waveForm: WaveForm.sine,
      duration: 0.2,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'hihat',
      waveForm: WaveForm.sine,
      duration: 0.1,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'cymbal',
      waveForm: WaveForm.sine,
      duration: 0.5,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'rideCymbal',
      waveForm: WaveForm.sine,
      duration: 1.0,
      generateWhiteNoise: true,
      volume: 0.05,
    );
  }

  @override
  void renderLoop() {
    _renderer.rect(
      x: 250,
      y: 120,
      width: 325,
      height: 300,
      color: black,
    );

    _renderer.rect(
      x: 252,
      y: 122,
      width: 321,
      height: 296,
      color: hexToColor('#201904'),
    );

    _renderer.rect(
      x: 262,
      y: 132,
      width: 301,
      height: 276,
      color: black,
    );

    _renderer.rect(
      x: 360,
      y: 142,
      width: 100,
      height: 16,
      color: hexToColor('#202021'),
    );

    _renderer.print(msg: 'bass', x: 365, y: 155, font: Font('led', 200, white));

    for (int i = 0; i < 16; i++) {
      _renderer.circle(x: 275 + i * 18, y: 350, radius: 4, color: drkGray);
    }
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
    if (_timer.hasTimePassed()) {
      for (final key in _drumTrack.keys) {
        if (_drumTrack[key]![_currentBar] == 1) {
          _wavFormSynthesis.play(key);
        }
      }

      _currentBar++;
      if (_currentBar > 15) {
        _currentBar = 0;
      }

      _timer.reset();
    }
  }

  @override
  List<Widget> getWidgets() {
    final List<Widget> widgets = [];

    final windowWidget = WindowWidget(
      id: 'drumMachine',
      x: 262,
      y: 132,
      width: 300,
      height: 276,
    );

    final buttonColors = [red, orange, yellow, ltGray];
    final buttonHoverColors = [brightRed, brightOrange, brightYellow, white];
    int j = 0;

    for (int i = 0; i < 16; i++) {
      windowWidget.addWidget(
        ButtonWidget(
          id: 'drumMachine',
          x: 5 + i * 18,
          y: 230,
          width: 16,
          height: 24,
          color: buttonColors[j],
          mouseOverColor: buttonHoverColors[j],
          onClick: () {},
        ),
      );

      if ((i + 1) % 4 == 0) {
        j++;
      }
    }

/*
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
          _wavFormSynthesis.play('cymbal');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'rideCymbal',
        x: 250,
        y: 10,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          _wavFormSynthesis.play('cymbal');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'tomTom',
        x: 100,
        y: 50,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          _wavFormSynthesis.play('lowToms');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'tomTom',
        x: 100,
        y: 100,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          _wavFormSynthesis.play('midToms');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'tomTom',
        x: 100,
        y: 150,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          _wavFormSynthesis.play('highToms');
        },
      ),
    );

    windowWidget.addWidget(
      ButtonWidget(
        id: 'tomTom',
        x: 0,
        y: 150,
        width: 24,
        height: 24,
        color: red,
        mouseOverColor: white,
        onClick: () {
          _wavFormSynthesis.play('triangle');
        },
      ),
    );*/

    widgets.add(windowWidget);

    return widgets;
  }
}
