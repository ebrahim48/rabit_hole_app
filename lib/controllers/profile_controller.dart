import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
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
        await getProfile();
        await getGamingDashBoard();
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
        await createGamingDashboard(
            totalCarrots: totalCarrots,
            highScoreInFt: highScoreInFt,
            context: context
        );
      } else {
        await updateGamingDashboard(
            totalCarrots: totalCarrots,
            highScoreInFt: highScoreInFt,
            context: context
        );
      }
    } catch (e) {
      print('Error in saveGameProgress: $e');
    }
  }


  /// ================================>  Share & Get Skin  ==============================>
  RxBool shareSkinLoading = false.obs;

  Future<void> shareAndGetSkin({required BuildContext context}) async {
    shareSkinLoading.value = true;

    try {
      const String appLink = 'https://play.google.com/store/apps/details?id=com.rabbithole.game';
      const String shareMessage = '''
🐰 Carrot Chase - Rabbit Hole Game! 🥕

Fall down the rabbit hole and collect carrots!
🎁 Share to get a FREE SKIN! 🎁

Download: $appLink
    ''';

      await Share.share(shareMessage);

      await Future.delayed(const Duration(milliseconds: 500));

      var response = await ApiClient.postData(
          ApiConstants.shareSkinDashboardEndPoint,
          '{}'
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getGamingDashBoard();
        await getProfile();
      }
    } catch (e) {
      print('Share error: $e');
    } finally {
      shareSkinLoading.value = false;
    }
  }

  /// ================================>  Watch Ads & Get Carrots  ==============================>
  RxBool watchAdsLoading = false.obs;

  Future<void> watchAdsAndGetCarrots({required BuildContext context}) async {
    watchAdsLoading.value = true;

    var body = {
      "adsWatched": 2
    };

    try {
      var response = await ApiClient.postData(
          ApiConstants.watchCarrotsDashboardEndPoint,
          jsonEncode(body)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getGamingDashBoard();
        await getProfile();
      }
    } catch (e) {
      print('Watch Ads error: $e');
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

      if (file != null) {
        multipartBody.add(MultipartBody("profileImage", file));
      }

      var body = {
        "fullName": fullName.trim(),
        "address": address.trim(),
        "phone": phone.trim(),
      };

      var response = await ApiClient.patchMultipartData(
        ApiConstants.updateProfileEndPoint,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getProfile();

        if (context.mounted) {
          context.pop();
        }
      }
    } catch (e) {
      print('Update Profile error: $e');
    } finally {
      updateProfileLoading(false);
      update();
    }
  }


}




