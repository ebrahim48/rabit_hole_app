import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/controllers/profile_controller.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/global/custom_assets/assets.gen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

class GameOverWidget extends StatefulWidget {
  final RabbitGame game;
  final VoidCallback onRestart;

  const GameOverWidget({
    super.key,
    required this.game,
    required this.onRestart,
  });

  @override
  State<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget> {
  final ProfileController profileController = Get.find<ProfileController>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    // Automatically save game progress when game over
    _saveGameProgress();
  }

  Future<void> _saveGameProgress() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      // Calculate total carrots earned (game carrots * 5)
      int carrotsEarned = widget.game.carrots * 5;

      // Get current total carrots from profile
      int currentTotalCarrots = profileController.profile.value.totalCarrots ?? 0;
      int newTotalCarrots = currentTotalCarrots + carrotsEarned;

      // Save game progress (auto create or update)
      await profileController.saveGameProgress(
        totalCarrots: newTotalCarrots,
        highScoreInFt: widget.game.distance.toInt(),
        context: context,
      );
    } catch (e) {
      print('Error saving game progress: $e');
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 375.w,
        height: 700,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.ganeheart.svg(height: 48.h, width: 48.w),
              SizedBox(height: 8.h),
              CustomText(
                text: "Game Over!",
                color: AppColors.textColor000000,
                fontsize: 20.sp,
                fontWeight: FontWeight.w600,
              ),

              CustomText(
                text: "The rabbit hit an obstacle",
                color: AppColors.textColor333333,
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 12.h),

              // Distance Container
              Container(
                width: 346.w,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white.withOpacity(0.85),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Distance',
                      color: AppColors.textColor333333,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: "${widget.game.distance.toInt()} ft",
                      color: AppColors.textColor000000,
                      fontsize: 26.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Obx(() => CustomText(
                      text: "Best: ${profileController.gamingDashBoard.value.gameDashboard?.highScoreInFt ?? widget.game.distance.toInt()} ft",
                      color: AppColors.textColor333333,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Carrots Earned Container
              Container(
                width: 346.w,
                height: 75.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          SizedBox(width: 18.w),
                          Assets.icons.carrotearn.svg(height: 24.h, width: 24.w),
                          SizedBox(width: 18.w),
                          CustomText(
                            text: "Carrots Earned:",
                            color: AppColors.textColor000000,
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          CustomText(
                            text: "+${widget.game.carrots * 5}",
                            color: AppColors.textColor000000,
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 18.w),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        text:
                        "Special Note: Exchange 20 Super-carrots for 1 Original Carrot.",
                        color: AppColors.textColor000000,
                        fontsize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Play Again Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD93B),
                  minimumSize: Size(346.w, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: isSaving
                    ? null
                    : () {
                  widget.game.overlays.remove('GameOver');
                  widget.onRestart();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isSaving)
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    else
                      Assets.icons.play.svg(height: 16.h, width: 16.w),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: isSaving ? "Saving..." : "Play Again",
                      color: AppColors.textColor000000,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Watch Ad Button
              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF87914),
                  minimumSize: Size(346.w, 42.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: profileController.watchAdsLoading.value
                    ? null
                    : () async {
                  await profileController.watchAdsAndGetCarrots(
                      context: context
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (profileController.watchAdsLoading.value)
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      Assets.icons.watch.svg(height: 16.h, width: 16.w),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: profileController.watchAdsLoading.value
                          ? "Loading..."
                          : "Watch Ad for +20 Carrots",
                      color: AppColors.textColorFFFFFF,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              )),
              SizedBox(height: 16.h),

              // Leaderboard & Home Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      minimumSize: Size(170.w, 42.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      context.pushNamed(AppRoutes.leaderBoardScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.leaderboard.svg(),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "Leaderboard",
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor000000,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      minimumSize: Size(170.w, 42.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      context.pushNamed(AppRoutes.bottomNavbarScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.home.svg(),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "Home",
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor000000,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Share Button
              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD93B),
                  minimumSize: Size(345.w, 42.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: profileController.shareSkinLoading.value
                    ? null
                    : () async {
                  await profileController.shareAndGetSkin(
                      context: context
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (profileController.shareSkinLoading.value)
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    else
                      Assets.icons.share.svg(height: 16.h, width: 16.w),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: profileController.shareSkinLoading.value
                          ? "Loading..."
                          : "Share & Get Free Skin!",
                      color: AppColors.textColor000000,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              )),
              SizedBox(height: 20.h),

              // Footer Quote
              CustomText(
                text:
                '"Being at the beginning, and go on till you come the end: then stop."',
                fontsize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor8A8A8A,
              ),
            ],
          ),
        ),
      ),
    );
  }
}