
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(
        title: 'Reset',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),
              Center(child: Assets.images.logo.image(height: 100.h, width: 100.w)),
              SizedBox(height: 24.h),

              CustomText(
                text: 'Reset Your Password.',
                color: AppColors.textColor000000,
                fontsize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 7.h),

              CustomText(
                text: 'Please enter your email to reset your password.',
                color: AppColors.textColor545454,
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 49.h),

              CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: passWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "Password",
                  isPassword: true),
              CustomTextField(
                hintextColor: AppColors.textColor545454,
                controller: confirmPassWordCtrl,
                prefixIcon: Assets.icons.pass.svg(),
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Future.delayed(Duration.zero, () => isMatched.value = false);
                    return 'Please enter your confirm password';
                  } else if (passWordCtrl.text == value) {
                    Future.delayed(Duration.zero, () => isMatched.value = true);
                    return null;
                  } else {
                    Future.delayed(Duration.zero, () => isMatched.value = false);
                    return 'Password Not Matching';
                  }
                },
                onChanged: (value) {
                  isMatched.value = passWordCtrl.text == value;
                },
              ),
              Obx(() => Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: isMatched.value ? 'Password Matched' : "",
                    color: Colors.green,
                    fontsize: 14.sp,
                  ))),



              SizedBox(height: 42.h),


              /// ============================================ Button ====================================>

              CustomButton(
                  title: "Reset Password",
                  onpress: () {
                    context.pushNamed(AppRoutes.signInScreen);
                    // Get.toNamed(AppRoutes.optScreen, arguments: {"screenType" : "Sign up"});
                  }),
              SizedBox(height: 27.h),

            ],
          ),
        ),
      ),
    );
  }






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

  RxBool isMatched = false.obs;
  RxBool isObscureConfirmPassword = true.obs;
  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  ismMatchedColor() {
    isMatched.value = !isMatched.value;
  }

  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController confirmPassWordCtrl = TextEditingController();


}
