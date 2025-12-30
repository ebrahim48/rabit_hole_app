import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_home_appbar.dart';
import '../../widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomHomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 34.h),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Rabbit Image
                    Assets.images.carrot.image(
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(height: 16.h),

                    /// Title
                    CustomText(
                      text: 'Carrot Chase',
                      color: AppColors.textColor000000,
                      fontsize: 29.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 12.h),

                    /// Subtitle
                    CustomText(
                      text: "How far can you fall?",
                      fontsize: 14.sp,
                      color: AppColors.textColor333333,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 42.h),

                    /// Start Game Button
                    SizedBox(
                      width: 345.w,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.gameScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textColorFFD93B,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.start.svg(
                              height: 16.h,
                              width: 16.w,
                            ),
                            SizedBox(width: 14.w),
                            Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                text: "Start Game",
                                textAlign: TextAlign.center,
                                fontsize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor000000,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    /// Options Grid
                    Wrap(
                      spacing: 20.w,
                      runSpacing: 20.h,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildOptionCard(
                          label: "High Scores",
                          icon: Assets.icons.scores.svg(
                            height: 32.h,
                            width: 32.w,
                          ),
                          onTap: () {
                            context.pushNamed(AppRoutes.leaderBoardScreen);
                          },
                        ),
                        _buildOptionCard(
                          label: "Shop",
                          icon: Assets.icons.shop.svg(
                            height: 32.h,
                            width: 32.w,
                          ),
                          onTap: () {
                            context.pushNamed(AppRoutes.shopScreen);
                          },
                        ),
                        _buildOptionCard(
                          label: "Profile",
                          icon: Assets.icons.nameProfile.svg(
                            height: 32.h,
                            width: 32.w,
                          ),
                          onTap: () {
                            context.pushNamed(AppRoutes.profileScreen);
                          },
                        ),
                        _buildOptionCard(
                          label: "Settings",
                          icon: Assets.icons.settings.svg(
                            height: 32.h,
                            width: 32.w,
                          ),
                          onTap: () {
                            context.pushNamed(AppRoutes.settingsScreen);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    /// Footer Quote
                    CustomText(
                      text: '"We\'re all mad here"',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor8A8A8A,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String label,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 162.w,
        height: 85.h,
        decoration: BoxDecoration(
          color: const Color(0xFF99CCE6),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFFFDE7C2),
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 6.h),
            CustomText(
              text: label,
              fontsize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor000000,
            ),
          ],
        ),
      ),
    );
  }
}
