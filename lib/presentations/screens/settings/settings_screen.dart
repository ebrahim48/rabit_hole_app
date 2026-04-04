import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_music_slider.dart';
import '../../../controllers/auth-controller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_haptic_feedback_slider.dart';
import '../../widgets/custom_slider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/menu_item.dart';
import '../../widgets/toggle_button.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthController authController = Get.put(AuthController());
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.bottomBackColorB3E5FC,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.r),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: 12.w),
            CustomText(
              text: "Settings",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================== Audio Settings Card ==================
            _buildAudioSettingsCard(),
            SizedBox(height: 18.h),

            /// ================== Controls Card ==================
            _buildControlsCard(),
            SizedBox(height: 18.h),

            // /// ================== Notifications ==================
            // _buildNotificationsCard(),
            // SizedBox(height: 18.h),

            /// ================== Others ==================
            _buildOthersCard(),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioSettingsCard() {
    return Container(
      width: 345.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.audio.svg(),
              SizedBox(width: 12.w),
              CustomText(
                text: "Audio Settings",
                fontsize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor000000,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.soundeffect.svg(),
                  SizedBox(width: 21.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Sound Effects",
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                      CustomText(
                        text: "Game sound and effects",
                        fontsize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() => ToggleButtonWidget(
                status: settingsController.soundEffects.value,
                onToggle: (value) {
                  settingsController.setSoundEffects(value);
                },
                activeColor: AppColors.buttonColorF9B039,
              )),
            ],
          ),
          SizedBox(height: 16.h),
          const CustomSoundSlider(),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.backgroundmusic.svg(),
                  SizedBox(width: 21.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Background Music",
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                      CustomText(
                        text: "Dynamic game soundtrack",
                        fontsize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() => ToggleButtonWidget(
                status: settingsController.backgroundMusic.value,
                onToggle: (value) {
                  settingsController.setBackgroundMusic(value);
                },
                activeColor: AppColors.buttonColorF9B039,
              )),
            ],
          ),
          SizedBox(height: 16.h),
          const CustomMusicSlider(),
        ],
      ),
    );
  }

  Widget _buildControlsCard() {
    return Container(
      width: 345.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.controls.svg(),
              SizedBox(width: 12.w),
              CustomText(
                text: "Controls",
                fontsize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor000000,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.soundeffect.svg(),
                  SizedBox(width: 21.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Haptic Feedback",
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                      CustomText(
                        text: "Vibration on collision",
                        fontsize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() => ToggleButtonWidget(
                status: settingsController.hapticFeedback.value,
                onToggle: (value) async {
                  await settingsController.setHapticFeedback(value);
                },
                activeColor: AppColors.buttonColorF9B039,
              )),
            ],
          ),
          SizedBox(height: 16.h),
          const CustomFeedbackSlider(),
          SizedBox(height: 8.h),
          CustomText(
            text: 'How responsive the rabbit movement is',
            color: AppColors.textColor545454,
            fontsize: 13.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildOthersCard() {
    return Container(
      width: 345.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.others.svg(),
              SizedBox(width: 12.w),
              CustomText(
                text: "Others",
                fontsize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor000000,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => _showChangePasswordModal(context),
            child: MenuItemWidget(
              icon: Assets.icons.changepass.svg(),
              text: "Change Password",
            ),
          ),
          SizedBox(height: 34.h),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.privacyScreen),
            child: MenuItemWidget(
              icon: Assets.icons.privacy.svg(),
              text: "Privacy Policy",
            ),
          ),
          SizedBox(height: 34.h),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.termsServiceScreen),
            child: MenuItemWidget(
              icon: Assets.icons.terms.svg(),
              text: "Terms of Service",
            ),
          ),
          SizedBox(height: 34.h),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.contactUsScreen),
            child: MenuItemWidget(
              icon: Assets.icons.contact.svg(),
              text: "Contact Us",
            ),
          ),
          SizedBox(height: 34.h),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.aboutUsScreen),
            child: MenuItemWidget(
              icon: Assets.icons.about.svg(),
              text: "About Us",
            ),
          ),
          SizedBox(height: 34.h),
          Divider(color: const Color(0xFFFFE4E4), thickness: 1),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => _showDeleteAccountDialog(context),
            child: Row(
              children: [
                Icon(Icons.delete_outline_rounded, color: const Color(0xFFD32F2F), size: 22.r),
                SizedBox(width: 21.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Delete Account",
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFD32F2F),
                    ),
                    CustomText(
                      text: "Permanently remove your account",
                      fontsize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFE57373),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.textColorFFFFFF,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: const Color(0xFFD32F2F), size: 24.r),
              SizedBox(width: 8.w),
              CustomText(
                text: "Delete Account",
                fontsize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFD32F2F),
              ),
            ],
          ),
          content: CustomText(
            text: "Are you sure you want to permanently delete your account? This action cannot be undone.",
            fontsize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor333333,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: CustomText(
                text: "Cancel",
                fontsize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor545454,
              ),
            ),
            Obx(() => settingsController.deleteAccountLoading.value
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () async {
                      final success = await settingsController.deleteAccount();
                      if (dialogContext.mounted) Navigator.pop(dialogContext);
                      if (success && context.mounted) {
                        context.go(AppRoutes.signInScreen);
                      }
                    },
                    child: CustomText(
                      text: "Delete",
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD32F2F),
                    ),
                  )),
          ],
        );
      },
    );
  }

  void _showChangePasswordModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (modalContext) {
        return ChangePasswordModalContent(authController: authController);
      },
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.textColorFFFFFF,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(width: 0.8, color: const Color(0xFFFFF3C2)),
      boxShadow: [
        BoxShadow(
          color: const Color(0x1F000000),
          offset: Offset(1.w, 3.h),
          blurRadius: 4.r,
        ),
      ],
    );
  }

}