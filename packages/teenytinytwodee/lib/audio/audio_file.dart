import 'dart:html';

class AudioFile {
  AudioFile(String fileName, bool loop) {
    _audio = AudioElement(fileName)
      ..loop = loop
      ..load(); // Preload the audio
  }
  late AudioElement _audio;

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

    _audio.play(); // No need to catch exceptions in Dart
  }

  void pause() {
    _audio.pause();
  }

  void stop() {
    _audio.pause();
    _audio.currentTime = 0; // Reset playback position
  }
}
