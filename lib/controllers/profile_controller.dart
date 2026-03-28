import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../helpers/toast_message_helper.dart';
import '../models/gaming_dashboard_model.dart';
import '../models/user_profile_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


class ProfileController extends GetxController {


  RxBool gamingDashBoardLoading = false.obs;
  Rx<GamingDashBoardModel> gamingDashBoard = Rx<GamingDashBoardModel>(GamingDashBoardModel());

  Future<void> getGamingDashBoard() async {
    gamingDashBoardLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiConstants.gamingDashboardEndPoint);
      if (response.statusCode == 200) {
        gamingDashBoard.value = GamingDashBoardModel.fromJson(response.body['data']['attributes']);
      }
    } catch (e) {
      print('DashBoard error: $e');
    } finally {
      gamingDashBoardLoading.value = false;
    }
  }

  /// ================================>  Create Gaming Dashboard  ==============================>
  RxBool createDashboardLoading = false.obs;

  Future<void> createGamingDashboard({
    required int totalCarrots,
    required int highScoreInFt,
    required BuildContext context
  }) async {
    createDashboardLoading.value = true;

    var body = {
      "totalCarrots": totalCarrots,
      "highScoreInFt": highScoreInFt
    };

    try {
      var response = await ApiClient.postData(
          ApiConstants.createDashboardEndPoint,
          jsonEncode(body)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage(
            'Game progress saved!',
            title: 'Success'
        );
        // Update profile - mark as played
        await getProfile();
        await getGamingDashBoard();
      } else {
        ToastMessageHelper.showToastMessage(
            'Failed to save progress',
            title: 'Error'
        );
      }
    } catch (e) {
      print('Create Dashboard error: $e');
    } finally {
      createDashboardLoading.value = false;
    }
  }

  /// ================================>  Update gaming Dashboard  ==============================>
  RxBool updateDashboardLoading = false.obs;

  Future<void> updateGamingDashboard({
    required int totalCarrots,
    required int highScoreInFt,
    required BuildContext context
  }) async {
    updateDashboardLoading.value = true;

    var body = {
      "totalCarrots": totalCarrots,
      "highScoreInFt": highScoreInFt
    };

    try {
      var response = await ApiClient.patch(
          ApiConstants.updateDashboardEndPoint,
          jsonEncode(body)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage(
            'Game progress updated!',
            title: 'Success'
        );
        await getGamingDashBoard();
      }
    } catch (e) {
      print('Update Dashboard error: $e');
    } finally {
      updateDashboardLoading.value = false;
    }
  }

  /// ================================>  Smart Save (Auto Create/Update)  ==============================>
  Future<void> saveGameProgress({
    required int totalCarrots,
    required int highScoreInFt,
    required BuildContext context
  }) async {
    try {
      await getGamingDashBoard();

      if (gamingDashBoard.value.gameDashboard == null) {
        print('🆕 Creating new dashboard...');
        await createGamingDashboard(
            totalCarrots: totalCarrots,
            highScoreInFt: highScoreInFt,
            context: context
        );
      } else {
        print('🔄 Updating existing dashboard...');
        await updateGamingDashboard(
            totalCarrots: totalCarrots,
            highScoreInFt: highScoreInFt,
            context: context
        );
      }
    } catch (e) {
      print('Error in saveGameProgress: $e');
      ToastMessageHelper.showToastMessage(
          'Failed to save progress',
          title: 'Error'
      );
    }
  }


  /// ================================>  Share & Get Skin  ==============================>
  RxBool shareSkinLoading = false.obs;

  Future<void> shareAndGetSkin({required BuildContext context}) async {
    shareSkinLoading.value = true;

    try {
      // Share message with app link
      const String appLink = 'https://play.google.com/store/apps/details?id=com.rabbithole.game';
      const String shareMessage = '''
🐰 Carrot Chase - Rabbit Hole Game! 🥕

Fall down the rabbit hole and collect carrots!
🎁 Share to get a FREE SKIN! 🎁

Download: $appLink
    ''';

      // Share the link
      await Share.share(shareMessage);

      // Small delay to ensure share dialog was shown
      await Future.delayed(const Duration(milliseconds: 500));

      // Call API to get skin reward
      var response = await ApiClient.postData(
          ApiConstants.shareSkinDashboardEndPoint,
          '{}'
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage(
            '🎉 Thank you for sharing! You got a new skin!',
            title: 'Success'
        );

        await getGamingDashBoard();
        await getProfile();
      } else {
        ToastMessageHelper.showToastMessage(
            response.body['message'] ?? 'Failed to get skin',
            title: 'Error'
        );
      }
    } catch (e) {
      print('Share error: $e');
      ToastMessageHelper.showToastMessage(
          'Failed to share',
          title: ''
      );
    } finally {
      shareSkinLoading.value = false;
    }
  }

  /// ================================>  Share App Link  ==============================>
  Future<void> _shareAppLink() async {
    try {
      const String appLink = 'https://play.google.com/store/apps/details?id=com.rabbithole.game'; // Replace with your actual app link
      const String message = '''
🐰 Carrot Chase - Rabbit Hole Game! 🥕

Play this amazing game and collect carrots! 
Fall down the rabbit hole and see how far you can go!

🎁 Share this link and get a FREE SKIN! 🎁

Download now: $appLink

#CarrotChase #RabbitHole #FreeGame
    ''';

      await Share.share(
        message,
        subject: 'Try Carrot Chase - Get Free Skin!',
      );
    } catch (e) {
      print('Share error: $e');
    }
  }
  /// ================================>  Watch Ads & Get Carrots  ==============================>
  RxBool watchAdsLoading = false.obs;

  Future<void> watchAdsAndGetCarrots({required BuildContext context}) async {
    watchAdsLoading.value = true;

    var body = {
      "adsWatched": 2 // Fixed value as per API requirement
    };

    try {
      var response = await ApiClient.postData(
          ApiConstants.watchCarrotsDashboardEndPoint,
          jsonEncode(body)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Get updated carrots count
        int totalCarrots = response.body['data']?['attributes']?['totalCarrots'] ?? 0;

        ToastMessageHelper.showToastMessage(
            'Game Dashboard updated successfully! +20 Carrots',
            title: 'Success'
        );

        // Refresh dashboard and profile
        await getGamingDashBoard();
        await getProfile();
      } else {
        ToastMessageHelper.showToastMessage(
            response.body['message'] ?? 'Failed to get carrots',
            title: ''
        );
      }
    } catch (e) {
      print('Watch Ads error: $e');
      ToastMessageHelper.showToastMessage(
          'Failed to watch ad',
          title: ''
      );
    } finally {
      watchAdsLoading.value = false;
    }
  }




  /// ================================>  Profile ==============================>

  RxBool getProfileLoading = false.obs;
  Rx<UserProfileModel> profile = UserProfileModel().obs;
  getProfile() async {
    getProfileLoading(true);
    var response = await ApiClient.getData(ApiConstants.userAccountEndPoint);
    if (response.statusCode == 200) {
      profile.value = UserProfileModel.fromJson(response.body['data']['attributes']);
      update();
      getProfileLoading(false);
    } else if (response.statusCode == 404) {
      getProfileLoading(false);
    }
  }





  /// ================================> Update Profile ==============================>
  var updateProfileLoading = false.obs;

  Future<void> updateProfile({
    required String fullName,
    required String address,
    required String phone,
    File? file,
    required BuildContext context
  }) async {
    updateProfileLoading(true);

    try {
      List<MultipartBody> multipartBody = [];

      // Add image file if provided
      if (file != null) {
        multipartBody.add(MultipartBody("profileImage", file));
      }

      // Prepare body data
      var body = {
        "fullName": fullName.trim(),
        "address": address.trim(),
        "phone": phone.trim(),
      };

      // Call API
      var response = await ApiClient.patchMultipartData(
        ApiConstants.updateProfileEndPoint,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage(
            response.body["message"] ?? "Profile updated successfully",
            title: 'Success'
        );

        // Refresh profile data
        await getProfile();

        // Navigate back
        if (context.mounted) {
          context.pop();
        }
      } else {
        ToastMessageHelper.showToastMessage(
            response.body["message"] ?? "Failed to update profile",
            title: 'Error'
        );
      }
    } catch (e) {
      print('Update Profile error: $e');
      ToastMessageHelper.showToastMessage(
          "Failed to update profile",
          title: 'Error'
      );
    } finally {
      updateProfileLoading(false);
      update();
    }
  }


}




