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
    required this.frequency,
    required this.audioContext,
    required this.duration,
    this.bufferSource,
  });
  final WaveForm waveForm;
  final num frequency;
  final num duration;
  final AudioContext audioContext;
  AudioBufferSourceNode? bufferSource;
}

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
    required num frequency,
    required num duration,
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
      bufferSource: generateWhiteNoise ? bufferSource : null,
    );

    logger(LogType.info, 'Registered sound wave: $name');
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
    oscillator.connectNode(gainNode);
    gainNode.connectNode(soundWave.audioContext.destination!);

    gainNode.gain!.setValueAtTime(1, soundWave.audioContext.currentTime!);
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

    // Gain envelope
    gainNode.gain!.setValueAtTime(1, soundWave.audioContext.currentTime!);
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