import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';
import '../../../global/custom_assets/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              /// --- Background Image ---
              Assets.images.splash.image(
                width: 393.w,
                height: 851.h,
                fit: BoxFit.cover,
              ),

              /// --- Content Over Image ---
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
                    CustomText(text:
                      "Let’s Hop into Action!",
                      fontsize: 18.sp,
                      color: AppColors.textColor333333,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 36.h),

                    /// Get Started Button
                    SizedBox(
                  width: 210.w,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.registerScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorC79235,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.h, left: 54.w),
                        child: SizedBox(
                          width: 96.w,
                          height: 22.h,
                          child: CustomText(
                            text: "Get Started",
                            textAlign: TextAlign.center,
                            fontsize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor000000,
                          ),
                        ),
                      ),
                    ),
                  ),
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
