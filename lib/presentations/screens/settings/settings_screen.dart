import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_button.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_music_slider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_haptic_feedback_slider.dart';
import '../../widgets/custom_slider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/menu_item.dart';
import '../../widgets/toggle_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool soundEffects = true;
  bool backgroundMusic = true;
  bool hapticFeedback = true;
  bool notification = true;



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
            Container(
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
              decoration: BoxDecoration(
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================================>  Title ===================================>
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

                  /// ========================================== Sound Effects ===============================>
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
                              CustomText(text: "Game sound and effects",
                                fontsize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor000000),
                            ],
                          ),
                        ],
                      ),
                      ToggleButtonWidget(
                          status: soundEffects,
                          onToggle: (value) {
                            setState(() {
                              soundEffects = value;
                            });
                          },
                          activeColor: AppColors.buttonColorF9B039,
                          ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// Volume Slider for Sound Effects
                  const CustomSoundSlider(),

                  SizedBox(height: 32.h),

                  /// =====================================> Background Music ==================================>
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
                              CustomText(text: "Background Music",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor000000,),
                              CustomText(text: "Dynamic game soundtrack",
                                fontsize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor000000),
                            ],
                          ),
                        ],
                      ),
                      ToggleButtonWidget(
                        status: backgroundMusic,
                        onToggle: (value) {
                          setState(() {
                            backgroundMusic = value;
                          });
                        },
                        activeColor: AppColors.buttonColorF9B039,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  /// Volume Slider for Background Music
                const CustomMusicSlider(),


                ],
              ),
            ),

            SizedBox(height: 18.h),
            /// ================== Controls Card ==================
            Container(
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
              decoration: BoxDecoration(
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================================>  Title ===================================>
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

                  /// ========================================== Haptic Feedback ===============================>
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
                              CustomText(text: "Vibration on collision",
                                  fontsize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor000000),
                            ],
                          ),
                        ],
                      ),
                      ToggleButtonWidget(
                        status: hapticFeedback,
                        onToggle: (value) {
                          setState(() {
                            hapticFeedback = value;
                          });
                        },
                        activeColor: AppColors.buttonColorF9B039,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// Volume Slider for Sound Effects
                  const CustomFeedbackSlider(),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'How responsive the rabbit movement is',
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,

                  )



                ],
              ),
            ),
            SizedBox(height: 18.h),

            /// ================== Notifications ==================
            Container(
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
              decoration: BoxDecoration(
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================================>  Title ===================================>
                  Row(
                    children: [
                      Assets.icons.audio.svg(),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: "Notification",
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// ========================================== Haptic Feedback ===============================>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.icons.hapticfeedback.svg(),
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
                              CustomText(text: "Vibration on collision",
                                  fontsize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor000000),
                            ],
                          ),
                        ],
                      ),
                      ToggleButtonWidget(
                        status: notification,
                        onToggle: (value) {
                          setState(() {
                            notification = value;
                          });
                        },
                        activeColor: AppColors.buttonColorF9B039,
                      ),
                    ],
                  ),





                ],
              ),
            ),
            SizedBox(height: 18.h),

            /// ================== Others ==================
            Container(
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
              decoration: BoxDecoration(
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================================>  Title ===================================>
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

                  /// ========================================== MEnu ===============================>

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Container(
                              width: 393.w,
                              height: 440.h,
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.r),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 40.w,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 39.h),
                                    CustomText(
                                      text: 'Password Change',
                                      color: AppColors.textColor000000,
                                      fontsize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 28.h),

                                    /// Example fields
                                    CustomTextField(
                                        hintextColor: AppColors.textColor545454,
                                        controller: currentPassWordCtrl,
                                        prefixIcon: Assets.icons.pass.svg(),
                                        hintText: "Current Password",
                                        isPassword: true),

                                    Align(
                                        alignment: Alignment.topRight,
                                        child:
                                        CustomText(
                                            text: 'Forget Password?')),

                                    SizedBox(height: 22.h),

                                    CustomTextField(
                                        hintextColor: AppColors.textColor545454,
                                        controller: newPassWordCtrl,
                                        prefixIcon: Assets.icons.pass.svg(),
                                        hintText: "New Password",
                                        isPassword: true),
                                    CustomTextField(
                                      hintextColor: AppColors.textColor545454,
                                      controller: confirmNewPassWordCtrl,
                                      prefixIcon: Assets.icons.pass.svg(),
                                      hintText: "Confirm New Password",
                                      isPassword: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          Future.delayed(Duration.zero, () => isMatched.value = false);
                                          return 'Please enter your confirm password';
                                        } else if (currentPassWordCtrl.text == value) {
                                          Future.delayed(Duration.zero, () => isMatched.value = true);
                                          return null;
                                        } else {
                                          Future.delayed(Duration.zero, () => isMatched.value = false);
                                          return 'Password Not Matching';
                                        }
                                      },
                                      onChanged: (value) {
                                        isMatched.value = currentPassWordCtrl.text == value;
                                      },
                                    ),
                                    Obx(() => Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomText(
                                          text: isMatched.value ? 'Password Matched' : "",
                                          color: Colors.green,
                                          fontsize: 14.sp,
                                        ))),


                                    SizedBox(height: 24.h),
                                    CustomButton(
                                      title: 'Save Change',
                                      onpress: () {

                                      },)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: MenuItemWidget(
                      icon: Assets.icons.changepass.svg(),
                      text: "Change Password",
                    ),
                  ),

                  SizedBox(height: 34.h),
                   GestureDetector(
                     onTap: () {
                       context.pushNamed(AppRoutes.privacyScreen);
                     },
                     child: MenuItemWidget(
                       icon: Assets.icons.privacy.svg(),
                      text: "Privacy Policy",
                                       ),
                   ),
                  SizedBox(height: 34.h),
                   GestureDetector(
                     onTap: () {
                       context.pushNamed(AppRoutes.termsServiceScreen);
                     },
                     child: MenuItemWidget(
                       icon: Assets.icons.terms.svg(),
                      text: "Terms of Service",
                                       ),
                   ),
                  SizedBox(height: 34.h),
                   GestureDetector(
                     onTap: () {

                     },
                     child: MenuItemWidget(
                       icon: Assets.icons.contact.svg(),
                      text: "Contact Us",
                                       ),
                   ),
                  SizedBox(height: 34.h),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.aboutUsScreen);
                    },
                    child: MenuItemWidget(
                      icon: Assets.icons.about.svg(),
                      text: "About Us",
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 16.h,)



          ],
        ),
      ),
    );
  }


  RxBool isMatched = false.obs;
  RxBool isObscureConfirmPassword = true.obs;
  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  ismMatchedColor() {
    isMatched.value = !isMatched.value;
  }

  final TextEditingController currentPassWordCtrl = TextEditingController();
  final TextEditingController newPassWordCtrl = TextEditingController();
  final TextEditingController confirmNewPassWordCtrl = TextEditingController();
}







