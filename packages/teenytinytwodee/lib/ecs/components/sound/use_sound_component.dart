import 'package:teenytinytwodee/audio/audio_manager.dart';
import 'package:teenytinytwodee/ecs/game_component.dart';

class UseSoundComponent implements GameComponent {
  UseSoundComponent(this.soundName, this.soundFile) {
    _audioManager.register(soundName, soundFile);
  }

  String soundFile;
  String soundName;
  final AudioManager _audioManager = AudioManager();

  @override
  String get name => 'useSound';
}
