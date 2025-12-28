import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';


class ResetPasswordScreen extends StatelessWidget {
  final String? email;

  ResetPasswordScreen({super.key, this.email});

  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isMatched = false.obs;
  final RxBool isObscureConfirmPassword = true.obs;

  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController confirmPassWordCtrl = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Reset',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
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
                  text: 'Please enter your new password.',
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
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
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

                Obx(() => CustomButton(
                    title: authController.setPasswordLoading.value
                        ? "Resetting..."
                        : "Reset Password",
                    onpress: () {
                      if (authController.setPasswordLoading.value) return;

                      if (formKey.currentState!.validate()) {
                        authController.setPassword(
                          email ?? '',
                          passWordCtrl.text,
                          confirmPassWordCtrl.text,
                          context: context,
                        );
                      }
                    })),
                SizedBox(height: 27.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  void ismMatchedColor() {
    isMatched.value = !isMatched.value;
  }
}