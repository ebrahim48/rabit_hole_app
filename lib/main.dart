import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:device_preview/device_preview.dart';
import 'package:rabbit_hole_app/core/app_constants/app_constants.dart';
import 'package:rabbit_hole_app/core/helpers/haptic_helper.dart';
import 'package:rabbit_hole_app/presentations/controller/theme_controller.dart';
import 'package:toastification/toastification.dart';

import 'core/config/app_routes/app_routes.dart';
import 'core/config/app_themes/app_themes.dart';
import 'core/helpers/dependancy_injaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PlatformDispatcher.instance.onAccessibilityFeaturesChanged = () {};
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  di.lockDevicePortrait();

  // Initialize haptic feedback setting with default value
  bool hapticFeedbackEnabled = await HapticHelper.getHapticFeedbackStatus();
  if (hapticFeedbackEnabled == false) { // If not set before, set to true as default
    await HapticHelper.setHapticFeedbackStatus(true);
  }

  Get.put(ThemeController());
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Rabbit Hole App',
            theme: Themes().lightTheme,
            darkTheme: Themes().lightTheme,
            builder: DevicePreview.appBuilder,
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            // darkTheme: ThemeData.dark(),
            themeMode: Get.find<ThemeController>().themeMode.value,
            routeInformationParser: AppRoutes.goRouter.routeInformationParser,
            routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
            routerDelegate: AppRoutes.goRouter.routerDelegate,
            // builder: (context, child) {
            //   return Scaffold(body: NoInterNetScreen(child: child!));
            // },
          );
        },
      ),
    );
  }
}
