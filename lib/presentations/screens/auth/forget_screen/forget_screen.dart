import 'package:flutter/gestures.dart';
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


class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(
        title: 'Forget Password',
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
                text: 'Forgot Your Password?',
                color: AppColors.textColor000000,
                fontsize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h),

              CustomText(
                text: 'Please enter your email to reset your password.',
                color: AppColors.textColor545454,
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 58.h),


              /// <<< ============><>>> Forget pass  flied  << < ==============>>>

              CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: emailCtrl,
                  hintText: "Email",
                  prefixIcon: Assets.icons.email.svg(),
                  isEmail: true),


              SizedBox(height: 41.h),


              /// ============================================ Button ====================================>

              CustomButton(title: "Get Verification Code", onpress: () {
                context.pushNamed(AppRoutes.verifyScreen);
                // Get.toNamed(AppRoutes.optScreen, arguments: {"screenType" : "Sign up"});
              }),
              SizedBox(height: 27.h),

            ],
          ),
        ),
      ),
    );
  }




  final TextEditingController emailCtrl = TextEditingController();


}
