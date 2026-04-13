import 'package:get/get.dart';

class BottomNavController extends GetxController {
  static BottomNavController get instance => Get.find<BottomNavController>();

  RxInt currentIndex = 0.obs;

  /// Tracks which tabs have been visited at least once.
  /// Index 0 (Home) is pre-visited so it renders immediately.
  final RxSet<int> visitedTabs = <int>{0}.obs;

  void switchTab(int index) {
    visitedTabs.add(index);
    currentIndex.value = index;
  }

  void resetToHome() {
    currentIndex.value = 0;
    visitedTabs.value = {0};
  }
}
