import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'custom_pin_text_field.dart';


class VerifyScreen extends StatelessWidget {

  final String screenType;
  final String email;
  final String token;

  VerifyScreen({super.key,required this.screenType, required this.email,required this.token});


  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(
        title: 'Verify',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 42.h),
              Center(child: Assets.images.logo.image(height: 100.h, width: 100.w)),
              SizedBox(height: 24.h),

              CustomText(
                text: 'Enter Verification Code.',
                color: AppColors.textColor000000,
                fontsize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h),

              CustomText(
                text: 'Please enter the 6 digit verification code sent\n to your e-mail',
                color: AppColors.textColor545454,
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
                maxline: 2,
              ),
              SizedBox(height: 40.h),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPinCodeTextField(textEditingController: otpTEController),
                  SizedBox(height: 13.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        textAlign: TextAlign.center,
                        text: 'Didn’t get the code?',
                        color: AppColors.textColor000000,
                        fontWeight: FontWeight.w400,
                        fontsize: 13.sp,

                      ),
                      GestureDetector(
                        onTap: isCountingDown.value
                            ? null
                            : () {
                          startCountdown();
                        },
                        child: CustomText(
                          fontWeight: FontWeight.w600,
                          text: isCountingDown.value
                              ? '${'Resend in'} ${countdown.value}s'
                              : ' Resend',
                          color: isCountingDown.value
                              ? AppColors.secondary836531
                              : AppColors.textColor8C7720,
                          textDecoration: TextDecoration.underline,
                          fontsize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                ],
              ),



              SizedBox(height: 27.h),


              /// ============================================ Button ====================================>

              Obx(() =>
                  CustomButton(
                    loading: authController.verifyLoading.value,
                    title: "Verify",
                    onpress: () {
                      if (otpTEController.text.isEmpty) {
                        ToastMessageHelper.showToastMessage("Please enter OTP");
                        return;
                      }

                      authController.verfyEmail(
                        otpTEController.text,
                        email,
                        token,
                        screenType: screenType,
                        type: screenType == "signup" ? "Sign Up" : "Forgot",
                        context: context,
                      );
                    },
                  ),),
              SizedBox(height: 27.h),

            ],
          ),
        ),
      ),
    );
  }




  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController otpTEController = TextEditingController();

  final RxInt countdown = 60.obs;
  final RxBool isCountingDown = false.obs;

  void startCountdown() {
    isCountingDown.value = true;
    countdown.value = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isCountingDown.value = false;
      }
    });
  }


}
