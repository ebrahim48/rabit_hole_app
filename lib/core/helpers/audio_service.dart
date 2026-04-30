import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/core/helpers/settings_helper.dart';

class AudioService extends GetxController {
  static AudioService get instance => Get.find<AudioService>();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final Map<String, AudioPlayer> _soundPlayers = {};

  RxBool isMusicPlaying = false.obs;
  RxDouble musicVolume = 0.83.obs;
  RxDouble soundEffectsVolume = 0.83.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    
    // Set music to loop
    _musicPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _loadSettings() async {
    musicVolume.value = await SettingsHelper.getBackgroundMusicVolume();
    soundEffectsVolume.value = await SettingsHelper.getSoundEffectsVolume();
  }

  Future<void> setMusicVolume(double volume) async {
    musicVolume.value = volume;
    await SettingsHelper.setBackgroundMusicVolume(volume);
    await _updateMusicVolume();
  }

  Future<void> setSoundEffectsVolume(double volume) async {
    soundEffectsVolume.value = volume;
    await SettingsHelper.setSoundEffectsVolume(volume);
  }

  Future<void> _updateMusicVolume() async {
    bool musicEnabled = await SettingsHelper.getBackgroundMusic();
    if (musicEnabled) {
      await _musicPlayer.setVolume(musicVolume.value);
    }
  }

  /// Apply volume directly to the player without saving to prefs (called from SettingsController)
  Future<void> applyMusicVolume(double volume) async {
    musicVolume.value = volume;
    await _musicPlayer.setVolume(volume);
  }

  Future<void> playMusic() async {
    bool musicEnabled = await SettingsHelper.getBackgroundMusic();
    if (!musicEnabled) return;

    try {
      await _musicPlayer.setVolume(musicVolume.value);
      await _musicPlayer.play(AssetSource('audio/CC Background mp3.mp3'));
      isMusicPlaying.value = true;
    } catch (e) {
      print('Error playing music: $e');
    }
  }

  Future<void> stopMusic() async {
    try {
      await _musicPlayer.stop();
      isMusicPlaying.value = false;
    } catch (e) {
      print('Error stopping music: $e');
    }
  }

  Future<void> pauseMusic() async {
    try {
      await _musicPlayer.pause();
      isMusicPlaying.value = false;
    } catch (e) {
      print('Error pausing music: $e');
    }
  }

  Future<void> resumeMusic() async {
    bool musicEnabled = await SettingsHelper.getBackgroundMusic();
    if (!musicEnabled) return;

    try {
      await _musicPlayer.resume();
      isMusicPlaying.value = true;
    } catch (e) {
      print('Error resuming music: $e');
    }
  }

  Future<void> playSound(String soundName) async {
    bool soundEnabled = await SettingsHelper.getSoundEffects();
    if (!soundEnabled) return;

    try {
      // Create a new player for each sound effect (no reuse)
      final player = AudioPlayer();
      await player.setVolume(soundEffectsVolume.value);
      await player.play(AssetSource('audio/$soundName.mp3'));
      
      // Dispose player when done
      player.onPlayerComplete.listen((_) {
        player.dispose();
      });
    } catch (e) {
      print('Error playing sound $soundName: $e');
    }
  }

  Future<void> playCollectSound() async {
    await playSound('CC Item Pickup mp3');
  }

  Future<void> playHitSound() async {
    await playSound('CC Obstacle Hit mp3');
  }

  Future<void> playPowerUpSound() async {
    await playSound('CC PowerUp mp3');
  }

  @override
  void onClose() {
    _musicPlayer.dispose();
    for (var player in _soundPlayers.values) {
      player.dispose();
    }
    _soundPlayers.clear();
    super.onClose();
  }
}
