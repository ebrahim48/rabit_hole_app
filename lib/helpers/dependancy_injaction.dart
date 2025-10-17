import 'package:flutter/services.dart';
import 'package:get/get.dart';


class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    // Get.lazyPut(() => AuthController(), fenix: true);
    // Get.lazyPut(() => CustomerHomeController(), fenix: true);
    // Get.lazyPut(() => CustomerBookingController(), fenix: true);

  }

  void lockDevicePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}