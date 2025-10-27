import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../controllers/profile_controller.dart';
import '../../../core/config/app_routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/achievements_card.dart';
import '../../widgets/custom_loader.dart';
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
      body: Obx((){
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: 346.w,
                height: 85.h,
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                  left: 24.w,
                  right: 10.w,
                ),
                decoration:  BoxDecoration(
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
                    ///  (Profile + Text)
                    Row(
                      children: [
                        CustomProfileImage(
                            imageUrl: controller.profile.value.profileImage ?? 'N/A'),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: controller.profile.value.fullName ?? 'N/A',
                              color: AppColors.textColor000000,
                              fontsize: 23.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: controller.profile.value.currentGametag ?? 'N/A',
                              color: AppColors.textColor000000,
                              fontsize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),

                    ///  (Settings Icon)
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.editProfileScreen);



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
                    ///  Grid of statistics cards
                    Obx((){
                      if (controller.gamingDashBoardLoading.value) {
                        return const Center(child: CustomLoader());
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
                    }

                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
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



                    Obx((){
                      if (controller.gamingDashBoardLoading.value) {
                        return const Center(child: CustomLoader());
                      }
                     return Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.gamingDashBoard.value.gameDashboard!.achievedBadges!.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final achievements = controller.gamingDashBoard.value.gameDashboard?.achievedBadges?[index];
                            return AchievementsListCard(
                              icon: Assets.icons.firstfall.svg(width: 42.w, height: 42.h),
                              title: achievements?.name ?? 'N/A',
                              name: achievements?.description ?? 'N/A',
                              subtitle: "Unlocked",
                              onTap: () {},
                            );
                          },
                        ),
                      );
                    }

                    ),


                  ],
                ),
              ),

              SizedBox(height: 16.h),
              Container(
                width: 346.w,
                padding: EdgeInsets.only(top: 16.sp,left: 14.w),
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
                              color: Color(0xFF9C0000),
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
      }

      ),

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
                          context.pushNamed(AppRoutes.signInScreen);
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
