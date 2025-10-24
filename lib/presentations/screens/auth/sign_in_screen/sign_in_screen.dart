import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';


class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(
        title: 'Login',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _logKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                Center(child: Assets.images.logo.image(height: 100.h, width: 100.w)),
                SizedBox(height: 24.h),

                CustomText(
                  text: 'Login',
                  color: AppColors.textColor000000,
                  fontsize: 23.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.h),

                CustomText(
                  text: 'Welcome Back! Please enter your details.',
                  color: AppColors.textColor545454,
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),

                SizedBox(height: 58.h),


                /// <<< ============><>>> Login in text flied  << < ==============>>>




                CustomTextField(
                    hintextColor: AppColors.textColor545454,
                    controller: emailCtrl,
                    hintText: "Email",
                    prefixIcon: Assets.icons.email.svg(),
                    isEmail: true),



                CustomTextField(
                    hintextColor: AppColors.textColor545454,
                    controller: passWordCtrl,
                    prefixIcon: Assets.icons.pass.svg(),
                    hintText: "Password",
                    isPassword: true),
                SizedBox(height: 20.h),

                /// ====================================> Check Box ========================>

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => Transform.translate(
                        offset: const Offset(0, -18),
                        child: Checkbox(
                          activeColor: AppColors.primaryColorC79235,
                          checkColor: AppColors.splashColor,
                          side: BorderSide(color: AppColors.textColor333333,width: 2.w),
                          value: isChecked.value,
                          onChanged: (value) {
                            isChecked.value = value!;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Remember Me ',
                            color: AppColors.textColor000000,
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: (){
                              if(emailCtrl.text.isEmpty){
                                ToastMessageHelper.showToastMessage("Please enter your email",title: 'Attention');
                              }else{
                                context.pushNamed(AppRoutes.forgetPasswordScreen, extra: emailCtrl.text);
                              }
                            },
                            child: CustomText(
                              text: 'Forget Password?',
                              color: AppColors.textColor8C7720,
                              fontsize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textDecoration: TextDecoration.underline,

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                /// ============================================ Button ====================================>

                Obx(()=>
                    CustomButton(
                        loading: authController.logInLoading.value,
                        title: "Login",
                        onpress: (){
                          if (_logKey.currentState?.validate()?? true) {
                            authController.handleLogIn(
                                emailCtrl.text, passWordCtrl.text.trim(),
                                context: context);
                          }
                        }
                    ),),

                SizedBox(height: 27.h),
                /// ===================================> Divider =============================>
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        margin: EdgeInsets.only(left: 7.w),
                        decoration:   const BoxDecoration(
                            color: AppColors.textColor000000
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomText(
                        text: 'Or Sign in with',
                        color: AppColors.textColor000000,
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        margin: EdgeInsets.only(right: 7.w),
                        decoration:  const BoxDecoration(
                            color: AppColors.textColor000000
                        ),
                      ),
                    ),
                  ],
                ),


                /// =================================> Social Icon ===========================>
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.google.svg(width: 40.w, height: 40.h),
                    SizedBox(width: 30.h),
                    Assets.icons.gmail.svg(width: 40.w, height: 40.h),
                  ],
                ),


                SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account ? ',
                        color: AppColors.textColor333333,
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.registerScreen);
                        },
                        child: CustomText(
                          text: ' Register',
                          color: AppColors.textColor85424D,
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 70.h)
              ],
            ),
          ),
        ),
      ),
    );
  }





  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  RxBool isChecked = false.obs;



}
