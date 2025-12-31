import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/profile_controller.dart';
import '../../../core/app_constants/app_constants.dart';
import '../../../core/config/app_routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helpers/prefs_helper.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../helpers/toast_message_helper.dart';
import '../../widgets/achievements_card.dart';
import '../../widgets/custom_logout_button.dart';
import '../../widgets/custom_profile_image.dart';
import '../../widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getGamingDashBoard();
      controller.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            CustomText(
              text: 'Profile',
              color: AppColors.textColor000000,
              fontsize: 18.sp,
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.settingsScreen);
                  },
                  icon: Assets.icons.settings.svg(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              Container(
                width: 346.w,
                height: 85.h,
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                  left: 24.w,
                  right: 10.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textColorFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1F000000),
                      offset: Offset(1.w, 3.h),
                      blurRadius: 4.r,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomProfileImage(
                            imageUrl: controller.profile.value?.profileImage ?? 'N/A'
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: controller.profile.value?.fullName ?? 'N/A',
                              color: AppColors.textColor000000,
                              fontsize: 23.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: controller.profile.value?.currentGametag ?? 'N/A',
                              color: AppColors.textColor000000,
                              fontsize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                            AppRoutes.updateProfileScreen,
                            extra: {
                              "profileImage": controller.profile.value?.profileImage ?? '',
                              "fullName": controller.profile.value?.fullName ?? '',
                              "address": controller.profile.value?.address ?? '',
                              "phone": controller.profile.value?.phone ?? ''
                            }
                        );
                      },
                      child: Assets.icons.profileedit.svg(
                        width: 42.w,
                        height: 42.h,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Statistics Section with Shimmer
              Container(
                width: 346.w,
                height: 380.h,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.textColorFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1F000000),
                      offset: Offset(1.w, 3.h),
                      blurRadius: 4.r,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Assets.icons.statistics.svg(),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: 'Statistics',
                          fontsize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor000000,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Statistics Grid with Shimmer
                    Obx(() {
                      if (controller.gamingDashBoardLoading.value) {
                        return Expanded(child: _buildStatisticsShimmer());
                      }

                      return Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildOptionCard(
                              subtitle: '${controller.gamingDashBoard.value.gameDashboard?.highScoreInFt ?? 'N/A'}',
                              label: "High Scores",
                              icon: Assets.icons.scores.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                              onTap: () {},
                            ),
                            _buildOptionCard(
                              subtitle: '${controller.gamingDashBoard.value.gameDashboard?.totalCarrots ?? 'N/A'}',
                              label: "Total carrots",
                              icon: Assets.icons.bigpacks.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                              onTap: () {},
                            ),
                            _buildOptionCard(
                              subtitle: '${controller.gamingDashBoard.value.gameDashboard?.numberOfGamesPlayed ?? 'N/A'}',
                              label: 'Game Played',
                              icon: Assets.icons.gameplay.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                              onTap: () {},
                            ),
                            _buildOptionCard(
                              subtitle: '${controller.gamingDashBoard.value.achievements ?? 'N/A'}',
                              label: "Achievements",
                              icon: Assets.icons.achievements.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Achievements Section with Shimmer
              Container(
                width: 346.w,
                height: 327.h,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.textColorFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1F000000),
                      offset: Offset(1.w, 3.h),
                      blurRadius: 4.r,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Assets.icons.achievements.svg(),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: 'Achievements',
                          fontsize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor000000,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Achievements List with Shimmer
                    Obx(() {
                      if (controller.gamingDashBoardLoading.value) {
                        return Expanded(child: _buildAchievementsShimmer());
                      }

                      final achievedBadges = controller.gamingDashBoard.value.gameDashboard?.achievedBadges ?? [];

                      if (achievedBadges.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  size: 48.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 8.h),
                                CustomText(
                                  text: 'No achievements yet',
                                  color: Colors.grey[600]!,
                                  fontsize: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: achievedBadges.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final achievement = achievedBadges[index];
                            return AchievementsListCard(
                              imageUrl: achievement.imgUrl ?? '',
                              title: achievement.name ?? 'N/A',
                              name: achievement.description ?? 'N/A',
                              subtitle: "Unlocked",
                              onTap: () {},
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Logout Button
              Container(
                width: 346.w,
                padding: EdgeInsets.only(top: 16.sp, left: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.textColorFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1F000000),
                      offset: Offset(1.w, 3.h),
                      blurRadius: 4.r,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 315.w,
                      height: 65.h,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.bottomBackColorB3E5FC,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _showLogoutConfirmationDialog(context);
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 36.w),
                            Padding(
                              padding: EdgeInsets.only(right: 19.w),
                              child: Assets.icons.logout.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                            ),
                            CustomText(
                              text: 'Logout',
                              color: const Color(0xFF9C0000),
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),

              SizedBox(height: 90.h)
            ],
          ),
        );
      }),
    );
  }

  // Statistics Shimmer
  Widget _buildStatisticsShimmer() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        4,
            (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 150.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
    );
  }

  // Achievements Shimmer
  Widget _buildAchievementsShimmer() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 346.w,
            height: 75.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionCard({
    required String label,
    required String subtitle,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: const Color(0xFFDEF0F9),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 6.h),
            CustomText(
              text: subtitle,
              fontsize: 18.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor000000,
            ),
            CustomText(
              text: label,
              fontsize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor000000,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: AppColors.textColorFFFFFF,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Log Out',
                  fontsize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor000000,
                ),
                SizedBox(height: 12.h),
                CustomText(
                  text: 'Do you want to log out your account?',
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor545454,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomLogTwoButton(
                        title: 'Cancel',
                        bgColor: AppColors.textColorFFFFFF,
                        textColor: AppColors.textColor000000,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomLogTwoButton(
                        title: 'Log Out',
                        bgColor: AppColors.buttonColorE8A533,
                        textColor: AppColors.textColorFFFFFF,
                        onTap: () async {
                          Navigator.pop(context);
                          await PrefsHelper.remove(AppConstants.bearerToken);
                          await PrefsHelper.remove(AppConstants.userId);
                          await PrefsHelper.remove(AppConstants.email);
                          await PrefsHelper.remove(AppConstants.role);
                          await PrefsHelper.setBool(AppConstants.isLogged, false);
                          Get.delete<ProfileController>(force: true);
                          if (context.mounted) {
                            context.go(AppRoutes.signInScreen);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}