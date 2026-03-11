import 'package:flutter/services.dart';
import 'package:rabbit_hole_app/core/app_constants/app_constants.dart';
import 'package:rabbit_hole_app/core/helpers/prefs_helper.dart';

class HapticHelper {
  static Future<bool> getHapticFeedbackStatus() async {
    return await PrefsHelper.getBool(AppConstants.hapticFeedback, defaultValue: true);
  }

  static Future<void> setHapticFeedbackStatus(bool isEnabled) async {
    await PrefsHelper.setBool(AppConstants.hapticFeedback, isEnabled);
  }

  static Future<double> getHapticIntensity() async {
    return await PrefsHelper.getDouble(AppConstants.hapticFeedbackIntensity, defaultValue: 0.83);
  }

  static Future<void> triggerLightFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  static Future<void> triggerMediumFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.mediumImpact();
    }
  }

  static Future<void> triggerHeavyFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static Future<void> triggerErrorFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static Future<void> triggerSelectionFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.selectionClick();
    }
  }
}