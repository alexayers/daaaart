import 'dart:math' as math;
import 'dart:web_audio';

import 'package:teenytinytwodee/logger/logger.dart';

enum WaveForm {
  sine,
  square,
  sawtooth,
  triangle,
}

class SoundWave {
  SoundWave({
    required this.waveForm,
    this.frequency,
    required this.audioContext,
    required this.duration,
    required this.volume,
    this.bufferSource,
  });
  final WaveForm waveForm;
  num? frequency;
  num duration;
  num volume;
  final AudioContext audioContext;
  AudioBufferSourceNode? bufferSource;
}

class SoundFilter {}

class WavFormSynthesis {
  factory WavFormSynthesis() {
    return _instance;
  }

  WavFormSynthesis._privateConstructor();

  static final WavFormSynthesis _instance =
      WavFormSynthesis._privateConstructor();
  final Map<String, SoundWave> _soundWaves = {};

  void register({
    required String name,
    required WaveForm waveForm,
    num? frequency,
    required num duration,
    required num volume,
    bool generateWhiteNoise = false,
  }) {
    final audioContext = AudioContext();

    late AudioBufferSourceNode bufferSource;

    if (generateWhiteNoise) {
      bufferSource = _generateWhiteNoise(audioContext);
    }

    _soundWaves[name] = SoundWave(
      audioContext: audioContext,
      waveForm: waveForm,
      frequency: frequency,
      duration: duration,
      volume: volume,
      bufferSource: generateWhiteNoise ? bufferSource : null,
    );

    logger(LogType.info, 'Registered sound wave: $name');
  }

  void update({required String name, num? frequency, num? volume}) {
    final soundWave = _soundWaves[name];

    if (soundWave == null) {
      logger(LogType.error, 'Sound wave not found: $name');
      return;
    }

    if (frequency != null) {
      soundWave.frequency = frequency;
    }

    if (volume != null) {
      soundWave.volume = volume;
    }
  }

  void increaseVolume(String name) {
    if (!_soundWaves.containsKey(name)) {
      logger(LogType.error, 'Sound wave not found: $name');
      return;
    }

    if (_soundWaves[name]!.volume >= 5) {
      return;
    }

    _soundWaves[name]!.volume += 0.1;
  }

  void decreaseVolume(String name) {
    if (!_soundWaves.containsKey(name)) {
      logger(LogType.error, 'Sound wave not found: $name');
      return;
    }

    if (_soundWaves[name]!.volume <= 0) {
      return;
    }

    _soundWaves[name]!.volume -= 0.1;
  }

  AudioBufferSourceNode _generateWhiteNoise(AudioContext audioContext) {
    late AudioBufferSourceNode bufferSource;

    final bufferSize = audioContext.sampleRate! ~/ 2;
    final buffer =
        audioContext.createBuffer(1, bufferSize, audioContext.sampleRate!);
    final data = buffer.getChannelData(0);

    // Fill buffer with white noise
    final random = math.Random();
    for (int i = 0; i < bufferSize; i++) {
      data[i] = random.nextDouble() * 2 - 1;
    }

    bufferSource = audioContext.createBufferSource();
    bufferSource.buffer = buffer;

    return bufferSource;
  }

  void play(String name) {
    final soundWave = _soundWaves[name];

    if (soundWave == null) {
      logger(LogType.error, 'Sound wave not found: $name');
      return;
    }

    final oscillator = soundWave.audioContext.createOscillator();

    oscillator.type = switch (soundWave.waveForm) {
      WaveForm.sine => 'sine',
      WaveForm.square => 'square',
      WaveForm.sawtooth => 'sawtooth',
      WaveForm.triangle => 'triangle',
    };

    oscillator.frequency!.value = soundWave.frequency;

    if (soundWave.bufferSource != null) {
      _playBuffer(soundWave);
      return;
    }

    final gainNode = soundWave.audioContext.createGain();

    gainNode.gain!
        .setValueAtTime(soundWave.volume, soundWave.audioContext.currentTime!);
    oscillator.connectNode(gainNode);
    gainNode.connectNode(soundWave.audioContext.destination!);

    gainNode.gain!.exponentialRampToValueAtTime(
      0.001,
      soundWave.audioContext.currentTime! + soundWave.duration,
    );

    oscillator.start2(soundWave.audioContext.currentTime);
    oscillator.stop(soundWave.audioContext.currentTime! + soundWave.duration);
  }

  void _playBuffer(SoundWave soundWave) {
    final gainNode = soundWave.audioContext.createGain();

    soundWave.bufferSource!.connectNode(gainNode);
    gainNode.connectNode(soundWave.audioContext.destination!);

    gainNode.gain!
        .setValueAtTime(soundWave.volume, soundWave.audioContext.currentTime!);
    gainNode.gain!.exponentialRampToValueAtTime(
      0.001,
      soundWave.audioContext.currentTime! + soundWave.duration,
    );

    soundWave.bufferSource!.start(soundWave.audioContext.currentTime);
    soundWave.bufferSource!.stop(
      soundWave.audioContext.currentTime! + soundWave.duration,
    );

    soundWave.bufferSource = _generateWhiteNoise(soundWave.audioContext);
  }
}
