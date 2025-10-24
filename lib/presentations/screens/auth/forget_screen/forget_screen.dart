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


class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key,required this.email});

  final String email;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  @override
  void initState() {
    print("====================${widget.email}");
    setState(() {
      emailCtrl.text = widget.email;
    });
    super.initState();
  }

  AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();

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


              Obx(()=>
                  CustomButton(
                      loading: authController.forgotLoading.value,
                      title: "Get Verification Code",
                      onpress: () {
                        if(_logKey.currentState?.validate()??true){
                          authController.handleForgot(
                              emailCtrl.text,
                              "forgot",
                              context: context);
                        }

                      }),),


              SizedBox(height: 27.h),

            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController emailCtrl = TextEditingController();
}
