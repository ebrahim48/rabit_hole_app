import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(
         title: 'Register',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Assets.images.logo.image(height: 100.h, width: 100.w)),
                SizedBox(height: 58.h),


                /// <<< ============><>>> sign up text flied  << < ==============>>>
                CustomTextField(
                    hintextColor: AppColors.textColor545454,
                    controller: nameCtrl,
                    hintText: "User name",
                    prefixIcon: Assets.icons.nameProfile.svg()),




                CustomTextField(
                    hintextColor: AppColors.textColor545454,
                    controller: emailCtrl,
                    hintText: "Email",
                    prefixIcon: Assets.icons.email.svg(),
                    isEmail: true),

                CustomTextField(
                  keyboardType: TextInputType.phone,
                  hintextColor: AppColors.textColor8A8A8A,
                  controller: phoneCtrl,
                  hintText: "Phone Number",
                  prefixIcon: Assets.icons.phone.svg(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    } else if (value.length < 11) {
                      return 'Phone number must be 11 digits';
                    } else if (value.length > 11) {
                      return 'Phone number cannot exceed 11 digits';
                    }
                    return null;
                  },
                ),


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
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: AppColors.textColor333333,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                          ),
                          children: [
                            const TextSpan(text: 'I have read & agreed to After hours '),
                            TextSpan(
                              text: 'Terms & Condition',
                              style:  TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.textColor8C7720,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Terms of Service
                                },
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                /// ============================================ Button ====================================>

                Obx(()=>
                   CustomButton(
                        // loading: authController.signUpLoading.value,
                      title: "Register",
                      onpress: () {
                        if(formKey.currentState?.validate()?? true){
                          authController.handleSignUp(
                            email: emailCtrl.text,
                            fullName: nameCtrl.text.trim(),
                            password: passWordCtrl.text.trim(),
                            confirmpassword: confirmPassWordCtrl.text.trim(),

                            context: context,
                            screenType: "signup",



                          );
                        }

                  }),
                ),
                SizedBox(height: 27.h),
                /// ===================================> Divider =============================>
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        margin: EdgeInsets.only(left: 7.w),
                        decoration: const BoxDecoration(
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
                        onTap: (){
                          context.pushNamed(AppRoutes.signInScreen);
                        },
                        child: CustomText(
                          text: ' Sign In',
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

  RxBool isMatched = false.obs;

  RxBool isObscureConfirmPassword = true.obs;

  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  ismMatchedColor() {
    isMatched.value = !isMatched.value;
  }

  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();


  final TextEditingController passWordCtrl = TextEditingController();

  final TextEditingController confirmPassWordCtrl = TextEditingController();

  RxBool isChecked = false.obs;
}
