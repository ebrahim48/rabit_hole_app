import 'dart:convert';

import 'package:get/get.dart';

import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


class GameController extends GetxController {

  var createGameLoading = false.obs;
  createGamingDashboard(String totalCarrots,highScoreInFt) async {

    var body = {
      'totalCarrots':totalCarrots,
      'highScoreInFt':highScoreInFt,
    };
    createGameLoading(true);
    var response = await ApiClient.postData(
        ApiConstants.createGamingDashBoardEndPoint,
        jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
    } else {

    }
    createGameLoading(false);

  }






  var updateDashboardLoading = false.obs;
  updateDashboard(
      String? totalCarrots,
      String? highScoreInFt,

      ) async {

    var body = {
      'totalCarrots':totalCarrots,
      'highScoreInFt':highScoreInFt,
    };
    updateDashboardLoading(true);
    var response = await ApiClient.patchData(
      ApiConstants.updateGamingDashBoardEndPoint,
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
    } else {
    }
    updateDashboardLoading(false);

  }





}
