import 'package:rabbit_hole_app/core/app_constants/app_constants.dart';
import 'package:rabbit_hole_app/core/helpers/prefs_helper.dart';

class SettingsHelper {
  // Sound Effects
  static Future<bool> getSoundEffects() async {
    return await PrefsHelper.getBool(AppConstants.soundEffects, defaultValue: true);
  }

  static Future<void> setSoundEffects(bool isEnabled) async {
    await PrefsHelper.setBool(AppConstants.soundEffects, isEnabled);
  }

  static Future<double> getSoundEffectsVolume() async {
    return await PrefsHelper.getDouble(AppConstants.soundEffectsVolume, defaultValue: 0.83);
  }

  static Future<void> setSoundEffectsVolume(double volume) async {
    await PrefsHelper.setDouble(AppConstants.soundEffectsVolume, volume);
  }

  // Background Music
  static Future<bool> getBackgroundMusic() async {
    return await PrefsHelper.getBool(AppConstants.backgroundMusic, defaultValue: true);
  }

  static Future<void> setBackgroundMusic(bool isEnabled) async {
    await PrefsHelper.setBool(AppConstants.backgroundMusic, isEnabled);
  }

  static Future<double> getBackgroundMusicVolume() async {
    return await PrefsHelper.getDouble(AppConstants.backgroundMusicVolume, defaultValue: 0.83);
  }

  static Future<void> setBackgroundMusicVolume(double volume) async {
    await PrefsHelper.setDouble(AppConstants.backgroundMusicVolume, volume);
  }

  // Haptic Feedback
  static Future<bool> getHapticFeedback() async {
    return await PrefsHelper.getBool(AppConstants.hapticFeedback, defaultValue: true);
  }

  static Future<void> setHapticFeedback(bool isEnabled) async {
    await PrefsHelper.setBool(AppConstants.hapticFeedback, isEnabled);
  }

  static Future<double> getHapticFeedbackIntensity() async {
    return await PrefsHelper.getDouble(AppConstants.hapticFeedbackIntensity, defaultValue: 0.83);
  }

  static Future<void> setHapticFeedbackIntensity(double intensity) async {
    await PrefsHelper.setDouble(AppConstants.hapticFeedbackIntensity, intensity);
  }
}
