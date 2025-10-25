import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:device_preview/device_preview.dart';
import 'package:rabbit_hole_app/presentations/controller/theme_controller.dart';

import 'core/config/app_routes/app_routes.dart';
import 'core/config/app_themes/app_themes.dart';
import 'core/helpers/dependancy_injaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PlatformDispatcher.instance.onAccessibilityFeaturesChanged = () {};
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  di.lockDevicePortrait();

  Get.put(ThemeController());
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
    );
  }
}
