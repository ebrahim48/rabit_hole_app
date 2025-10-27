import 'package:flutter/services.dart';
import 'package:rabbit_hole_app/core/app_constants/app_constants.dart';
import 'package:rabbit_hole_app/core/helpers/prefs_helper.dart';

class HapticHelper {
  static Future<bool> getHapticFeedbackStatus() async {
    return await PrefsHelper.getBool(AppConstants.hapticFeedback);
  }

  static Future<void> setHapticFeedbackStatus(bool isEnabled) async {
    await PrefsHelper.setBool(AppConstants.hapticFeedback, isEnabled);
  }

  static void triggerLightFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  static void triggerHeavyFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static void triggerErrorFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static void triggerSelectionFeedback() async {
    bool isEnabled = await getHapticFeedbackStatus();
    if (isEnabled) {
      HapticFeedback.selectionClick();
    }
  }
}