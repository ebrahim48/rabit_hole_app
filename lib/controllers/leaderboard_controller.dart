import 'package:get/get.dart';
import '../../../services/api_client.dart';
import '../../../services/api_constants.dart';
import '../models/leaderboard_models.dart';

class LeaderBoardController extends GetxController {
  RxBool getLeaderBoardLoading = false.obs;
  Rx<LeaderBoardModel?> leaderBoard = Rx<LeaderBoardModel?>(null);

  Future<void> getLeaderBoard() async {
    getLeaderBoardLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiConstants.gamingLeaderDashboardEndPoint);

      if (response.statusCode == 200) {
        final attributes = response.body["data"]["attributes"];
        leaderBoard.value = LeaderBoardModel.fromJson(attributes);
      }
    } catch (e) {
      print('Leaderboard fetch error: $e');
    } finally {
      getLeaderBoardLoading.value = false;
    }
  }
}




