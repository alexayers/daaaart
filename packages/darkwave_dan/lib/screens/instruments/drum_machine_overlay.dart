import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/audio/wave_form_synthesis.dart';
import 'package:teenytinytwodee/gui/button_widget.dart';
import 'package:teenytinytwodee/gui/dial_widget.dart';
import 'package:teenytinytwodee/gui/text_button_widget.dart';
import 'package:teenytinytwodee/gui/text_widget.dart';
import 'package:teenytinytwodee/gui/widget.dart';
import 'package:teenytinytwodee/gui/window_widget.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';
import 'package:teenytinytwodee/utils/timer_util.dart';

class DrumMachineOverlay extends GameScreenOverlay {
  final _renderer = Renderer();
  final _wavFormSynthesis = WavFormSynthesis();

  final _drumTrack = Map<String, List<int>>() = {
    'Bass Drum': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Snare': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Cymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Ride Cymbal': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Hi Hat': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Low Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Mid Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'High Tom': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Hand Clap': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Rim Shot': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    'Cow Bell': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  };

  int _currentBar = 0;
  int _currentBPM = 120;
  int _currentDelay = 120;
  String _currentInstrument = 'Hand Clap';
  final TimerUtil _timer = TimerUtil();

  @override
  void init() {
    _timer.waitTime = _currentBPM;

    _wavFormSynthesis.register(
      name: 'Bass Drum',
      waveForm: WaveForm.sine,
      frequency: 50,
      duration: 0.5,
      volume: 1.5,
    );

    _wavFormSynthesis.register(
      name: 'Rim Shot',
      waveForm: WaveForm.sine,
      frequency: 2000,
      duration: 0.1,
      volume: 1.0,
    );

    _wavFormSynthesis.register(
      name: 'Hand Clap',
      waveForm: WaveForm.square,
      frequency: 700,
      duration: 0.2,
      volume: 1.0,
      generateWhiteNoise: true,
    );

    _wavFormSynthesis.register(
      name: 'Cow Bell',
      waveForm: WaveForm.square,
      frequency: 800,
      duration: 0.3,
      volume: 0.1,
    );

    _wavFormSynthesis.register(
      name: 'Low Tom',
      waveForm: WaveForm.sine,
      frequency: 100,
      duration: 0.5,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'Mid Tom',
      waveForm: WaveForm.sine,
      frequency: 150,
      duration: 0.5,
      volume: 1,
    );

    _wavFormSynthesis.register(
      name: 'High Tom',
      waveForm: WaveForm.sine,
      frequency: 200,
      duration: 0.5,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'Snare',
      waveForm: WaveForm.sine,
      duration: 0.2,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'Hi Hat',
      waveForm: WaveForm.sine,
      duration: 0.1,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'Cymbal',
      waveForm: WaveForm.sine,
      duration: 0.5,
      generateWhiteNoise: true,
      volume: 0.05,
    );

    _wavFormSynthesis.register(
      name: 'Ride Cymbal',
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
      x: 270,
      y: 142,
      width: 100,
      height: 16,
      color: hexToColor('#202021'),
    );

    _renderer.print(
      msg: _currentInstrument,
      x: 280,
      y: 155,
      font: Font('vt323', 20, white),
    );

    _renderer.rect(
      x: 480,
      y: 142,
      width: 40,
      height: 16,
      color: hexToColor('#202021'),
    );

    _renderer.print(
      msg: _currentBPM.toString(),
      x: 487,
      y: 155,
      font: Font('vt323', 20, brightRed),
    );

    _renderer.print(
      msg: 'BPM',
      x: 520,
      y: 155,
      font: Font('vt323', 20, white),
    );

    for (int i = 0; i < 16; i++) {
      if (_drumTrack[_currentInstrument]![i] == 1) {
        _renderer.circle(x: 275 + i * 18, y: 350, radius: 4, color: brightRed);
      } else {
        if (i == _currentBar) {
          _renderer.circle(x: 275 + i * 18, y: 350, radius: 4, color: red);
        } else {
          _renderer.circle(x: 275 + i * 18, y: 350, radius: 4, color: drkGray);
        }
      }
    }
  }

  @override
  void keyboard(int keyCode) {
    // TODO: implement keyboard
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
          onClick: () {
            if (_drumTrack[_currentInstrument]![i] == 1) {
              _drumTrack[_currentInstrument]![i] = 0;
            } else {
              _drumTrack[_currentInstrument]![i] = 1;
              _wavFormSynthesis.play(_currentInstrument);
            }
          },
        ),
      );

      if ((i + 1) % 4 == 0) {
        j++;
      }
    }

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 8,
        y: 30,
        width: 30,
        height: 20,
        color: maroon,
        mouseOverColor: red,
        text: 'reset',
        font: Font('vt323', 12, white),
        onClick: () {
          for (final key in _drumTrack.keys) {
            for (int i = 0; i < 16; i++) {
              _drumTrack[key]![i] = 0;
            }
          }
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 230,
        y: 30,
        width: 20,
        height: 20,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: '-',
        font: Font('vt323', 16, white),
        onClick: () {
          if (_currentBPM > 40) {
            _currentBPM--;
            _currentDelay++;
            _timer.waitTime = _currentDelay;
          }
        },
      ),
    );

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: 260,
        y: 30,
        width: 20,
        height: 20,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: '+',
        font: Font('vt323', 16, white),
        onClick: () {
          if (_currentBPM < 200) {
            _currentBPM++;
            _currentDelay--;
            _timer.waitTime = _currentDelay;
          }
        },
      ),
    );

    windowWidget.addWidget(
      TextWidget(
        id: 'drumMachine',
        x: 130,
        y: 120,
        width: 30,
        height: 20,
        text: 'Volume',
        font: Font('vt323', 16, white),
      ),
    );

    int instrumentSelectorX = 10;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'BD',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Bass Drum';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );

    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'SD',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Snare';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'LT',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Low Tom';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'MT',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Mid Tom';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HT',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'High Tom';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'RS',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Rim Shot';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HC',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Hand Clap';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'CB',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Cow Bell';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'CY',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Cymbal';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'HH',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Hi Hat';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

    windowWidget.addWidget(
      TextButtonWidget(
        id: 'drumMachine',
        x: instrumentSelectorX,
        y: 160,
        width: 24,
        height: 24,
        color: cornflowerBlue,
        mouseOverColor: skyBlue,
        text: 'RS',
        font: Font('vt323', 16, white),
        onClick: () {
          _currentInstrument = 'Ride Cymbal';
        },
      ),
    );

    windowWidget.addWidget(
      DialWidget(
        id: 'drumMachine',
        x: instrumentSelectorX + 12,
        y: 140,
        width: 24,
        height: 24,
        radius: 10,
        currentValue: 50,
        minValue: 0,
        maxValue: 100,
        color: drkGray,
        mouseOverColor: ltGray,
      ),
    );
    instrumentSelectorX += 25;

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
