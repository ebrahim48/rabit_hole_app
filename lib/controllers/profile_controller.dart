import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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

  updateProfile({
    String? fullName,
    String? address,
    String? phone,
    File? file,
    required BuildContext context

  }) async {

    updateProfileLoading(true);

    List<MultipartBody> multipartBody = [];
    if (file != null) {
      multipartBody.add(MultipartBody("file", file));
    }



    var body = {
      "fullName": "$fullName",
      "address": "$address",
      "phone": "$phone",
    };


    updateProfileLoading(true);

    var response = await ApiClient.patchMultipartData(
        ApiConstants.updateProfileEndPoint,
        body,
        multipartBody: multipartBody
    );



    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      await getProfile();

      updateProfileLoading(false);
      context.pop();
      update();
    } else {
      updateProfileLoading(false);
      ToastMessageHelper.showToastMessage("Failed Update data.");
    }
  }



}




