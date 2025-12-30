import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';
import '../../../core/app_constants/app_constants.dart';
import '../../../core/helpers/prefs_helper.dart';
import '../../../global/custom_assets/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);

    if (mounted) {
      if (token.isNotEmpty && isLogged) {
        context.go(AppRoutes.bottomNavbarScreen);
      } else {
        context.go(AppRoutes.signInScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              /// Background Image
              Assets.images.splash.image(
                width: 393.w,
                height: 851.h,
                fit: BoxFit.cover,
              ),

              /// Content Over Image
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Rabbit Image
                    Assets.images.carrot.image(
                      width: 150.w,
                      height: 150.h,
                    ),
                    SizedBox(height: 16.h),

                    /// Title
                    Assets.images.carrotchase.image(
                      width: 220.w,
                      height: 45.h,
                    ),
                    SizedBox(height: 12.h),

                    /// Subtitle
                    CustomText(
                      text: "Let's Hop into Action!",
                      fontsize: 18.sp,
                      color: AppColors.textColor333333,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
