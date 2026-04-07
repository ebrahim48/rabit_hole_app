import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../core/app_constants/app_constants.dart';
import '../core/helpers/audio_service.dart';
import '../core/helpers/prefs_helper.dart';
import '../core/helpers/settings_helper.dart';
import '../models/contact_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class SettingsController extends GetxController{

  // Sound Effects
  RxBool soundEffects = true.obs;
  RxDouble soundEffectsVolume = 0.83.obs;

  // Background Music
  RxBool backgroundMusic = true.obs;
  RxDouble backgroundMusicVolume = 0.83.obs;

  // Haptic Feedback
  RxBool hapticFeedback = true.obs;
  RxDouble hapticFeedbackIntensity = 0.83.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    soundEffects.value = await SettingsHelper.getSoundEffects();
    soundEffectsVolume.value = await SettingsHelper.getSoundEffectsVolume();
    backgroundMusic.value = await SettingsHelper.getBackgroundMusic();
    backgroundMusicVolume.value = await SettingsHelper.getBackgroundMusicVolume();
    hapticFeedback.value = await SettingsHelper.getHapticFeedback();
    hapticFeedbackIntensity.value = await SettingsHelper.getHapticFeedbackIntensity();
  }

  Future<void> setSoundEffects(bool value) async {
    soundEffects.value = value;
    await SettingsHelper.setSoundEffects(value);
  }

  Future<void> setSoundEffectsVolume(double value) async {
    soundEffectsVolume.value = value;
    await SettingsHelper.setSoundEffectsVolume(value);
    // Real-time: update AudioService so next sound plays at new volume
    try {
      AudioService.instance.soundEffectsVolume.value = value;
    } catch (_) {}
  }

  Future<void> setBackgroundMusic(bool value) async {
    backgroundMusic.value = value;
    await SettingsHelper.setBackgroundMusic(value);
    // Real-time: pause or resume the music player immediately
    try {
      final audio = AudioService.instance;
      if (value) {
        await audio.resumeMusic();
      } else {
        await audio.pauseMusic();
      }
    } catch (_) {}
  }

  Future<void> setBackgroundMusicVolume(double value) async {
    backgroundMusicVolume.value = value;
    await SettingsHelper.setBackgroundMusicVolume(value);
    // Real-time: apply volume to the active music player
    try {
      await AudioService.instance.applyMusicVolume(value);
    } catch (_) {}
  }

  Future<void> setHapticFeedback(bool value) async {
    hapticFeedback.value = value;
    await SettingsHelper.setHapticFeedback(value);
    // Real-time: vibrate immediately when haptic is turned on
    if (value) {
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> setHapticFeedbackIntensity(double value) async {
    hapticFeedbackIntensity.value = value;
    await SettingsHelper.setHapticFeedbackIntensity(value);
  }


  RxBool getContactUsLoading = false.obs;
  Rx<ContactModel?> contact = Rx<ContactModel?>(null);

  contactUs() async {
    getContactUsLoading(true);
    var response = await ApiClient.getData(ApiConstants.contactUsEndPoint);
    if (response.statusCode == 200) {
      final data = response.body['data'];
      contact.value = ContactModel.fromJson(data);
    }
    getContactUsLoading(false);
  }

  /// ================================> Privacy Policy ==============================>
  RxBool getPrivacyPolicyLoading = false.obs;
  RxString value = "".obs;

  Future<void> privacyPolicy() async {
    getPrivacyPolicyLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.privacyEndPoint);
      if (response.statusCode == 200) {
        final attributes = response.body['data']?['attributes'];
        if (attributes != null && attributes is Map) {
          value.value = attributes['text']?.toString() ?? '';
        }
      }
    } catch (e) {
      print('Privacy Policy Error: $e');
    } finally {
      getPrivacyPolicyLoading(false);
    }
  }

// /// ================================> Privacy Policy  ==============================>
//
//   RxBool getPrivacyPolicyLoading = false.obs;
//   RxString value = "".obs;
//   privacyPolicy() async {
//     getPrivacyPolicyLoading(true);
//     var response = await ApiClient.getData(ApiConstants.privacyEndPoint);
//     if (response.statusCode == 200) {
//       value.value = response.body['data']['attributes'];
//       getPrivacyPolicyLoading(false);
//     } else if (response.statusCode == 404) {
//       getPrivacyPolicyLoading(false);
//     }
//   }


  /// ================================> About Us ==============================>
  RxBool getAboutUsLoading = false.obs;
  RxString about = "".obs;

  Future<void> aboutUs() async {
    getAboutUsLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.aboutUsEndPoint);
      if (response.statusCode == 200) {
        final attributes = response.body['data']?['attributes'];
        if (attributes != null && attributes is Map) {
          about.value = attributes['text']?.toString() ?? '';
        }
      }
    } catch (e) {
      print('About Us Error: $e');
    } finally {
      getAboutUsLoading(false);
    }
  }


  // /// ================================> About Us  ==============================>
  //
  // RxBool getAboutUsLoading = false.obs;
  // RxString about = "".obs;
  // aboutUs() async {
  //   getAboutUsLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.aboutUsEndPoint);
  //   if (response.statusCode == 200) {
  //     about.value = response.body['data'];
  //     getAboutUsLoading(false);
  //   } else if (response.statusCode == 404) {
  //     getAboutUsLoading(false);
  //   }
  // }

  // /// ================================> Terms Condition ==============================>
  //
  // RxBool getTermsConditionLoading = false.obs;
  // RxString terms = "".obs;
  // termsCondition() async {
  //   getTermsConditionLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.termsEndPoint);
  //   if (response.statusCode == 200) {
  //     terms.value = response.body['data']['attributes'];
  //     getTermsConditionLoading(false);
  //   } else if (response.statusCode == 404) {
  //     getTermsConditionLoading(false);
  //   }
  // }


  /// ================================> Delete Account ==============================>
  RxBool deleteAccountLoading = false.obs;

  Future<bool> deleteAccount() async {
    deleteAccountLoading(true);
    try {
      var response = await ApiClient.deleteData(ApiConstants.deleteAccountEndPoint);
      if (response.statusCode == 200) {
        await PrefsHelper.remove(AppConstants.bearerToken);
        await PrefsHelper.remove(AppConstants.userId);
        await PrefsHelper.remove(AppConstants.email);
        await PrefsHelper.remove(AppConstants.role);
        await PrefsHelper.setBool(AppConstants.isLogged, false);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      deleteAccountLoading(false);
    }
  }

  /// ================================> Terms Condition ==============================>
  RxBool getTermsConditionLoading = false.obs;
  RxString terms = "".obs;

  Future<void> termsCondition() async {
    getTermsConditionLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.termsEndPoint);
      if (response.statusCode == 200) {
        final attributes = response.body['data']?['attributes'];
        if (attributes != null && attributes is Map) {
          terms.value = attributes['text']?.toString() ?? '';
        }
      }
    } catch (e) {
      print('Terms Condition Error: $e');
    } finally {
      getTermsConditionLoading(false);
    }
  }

}