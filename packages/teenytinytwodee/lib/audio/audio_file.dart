import 'dart:html';

import 'package:teenytinytwodee/logger/logger.dart';

class AudioFile {
  AudioFile(String fileName, bool loop) {
    _audio = AudioElement(fileName)
      ..loop = loop
      ..load(); // Preload the audio
  }
  late AudioElement _audio;
  final _logger = Logger();

  set volume(double volume) {
    _audio.volume = volume;
  }

  double get volume {
    return _audio.volume as double;
  }

  bool isLooped() {
    return _audio.loop;
  }

  void play() {
    if (!_audio.paused) {
      _audio.pause();
      _audio.currentTime = 0; // Reset playback position
    }

    try {
      _audio.play();
    } catch (e) {
      _logger.error('Error playing audio: $e');
    }
  }

  void pause() {
    _audio.pause();
  }

  void stop() {
    _audio.pause();
    _audio.currentTime = 0; // Reset playback position
  }
}
