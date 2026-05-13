import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
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
      appBar: const CustomAppBar(title: 'Register'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Assets.images.logo.image(height: 100.h, width: 100.w),
                ),
                SizedBox(height: 58.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Assets.icons.nameProfile.svg(
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.w),
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: "Profile Image",
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor545454,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    /// ======================================> Profile image  camera icon ====================================>
                    GestureDetector(
                      onTap: () => showImagePickerOption(context),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColorC79235,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child:
                                  selectedImage != null
                                      ? Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      )
                                      : CustomNetworkImage(
                                        boxShape: BoxShape.circle,
                                        imageUrl: profileImagePath ?? "",
                                        height: 60.w,
                                        width: 60.w,
                                      ),
                            ),
                          ),

                          Positioned(
                            bottom: -4.h,
                            right: -4.w,
                            child: Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColors.primaryColorC79235,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: AppColors.textColor000000),

                /// <<< ============><>>> sign up text flied  << < ==============>>>
                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: nameCtrl,
                  hintText: "User name",
                  prefixIcon: Assets.icons.nameProfile.svg(),
                ),

                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: emailCtrl,
                  hintText: "Email",
                  prefixIcon: Assets.icons.email.svg(),
                  isEmail: true,
                ),

                CustomTextField(
                  keyboardType: TextInputType.phone,
                  hintextColor: AppColors.textColor545454,
                  controller: phoneCtrl,
                  hintText: "Phone Number",
                  prefixIcon: Assets.icons.phone.svg(
                    color: AppColors.textColor000000,
                  ),
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
                  controller: addressCtrl,
                  hintText: "Address",
                  prefixIcon: Assets.icons.address.svg(
                    color: AppColors.textColor000000,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),

                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: passWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "Password",
                  isPassword: true,
                ),
                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: confirmPassWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "Confirm Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Future.delayed(
                        Duration.zero,
                        () => isMatched.value = false,
                      );
                      return 'Please enter your confirm password';
                    } else if (passWordCtrl.text == value) {
                      Future.delayed(
                        Duration.zero,
                        () => isMatched.value = true,
                      );
                      return null;
                    } else {
                      Future.delayed(
                        Duration.zero,
                        () => isMatched.value = false,
                      );
                      return 'Password Not Matching';
                    }
                  },
                  onChanged: (value) {
                    isMatched.value = passWordCtrl.text == value;
                  },
                ),
                Obx(
                  () => Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: isMatched.value ? 'Password Matched' : "",
                      color: Colors.green,
                      fontsize: 14.sp,
                    ),
                  ),
                ),

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
                          side: BorderSide(
                            color: AppColors.textColor333333,
                            width: 2.w,
                          ),
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
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            const TextSpan(
                              text: 'I have read & agreed to After hours ',
                            ),
                            TextSpan(
                              text: 'Terms & Condition',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.textColor8C7720,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushNamed(
                                        AppRoutes.termsServiceScreen,
                                      );
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
                Obx(
                  () => CustomButton(
                    loading: authController.signUpLoading.value,
                    title: "Register",
                    onpress: () {
                      if (formKey.currentState?.validate() ?? true) {
                        authController.handleSignUp(
                          email: emailCtrl.text,
                          fullName: nameCtrl.text.trim(),
                          password: passWordCtrl.text.trim(),
                          confirmpassword: confirmPassWordCtrl.text.trim(),
                          address: addressCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                          profileImage: selectedImage,
                          context: context,
                          screenType: "signup",
                        );
                      }
                    },
                  ),
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
                          color: AppColors.textColor000000,
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
                        decoration: const BoxDecoration(
                          color: AppColors.textColor000000,
                        ),
                      ),
                    ),
                  ],
                ),

                /// =================================> Social Icon ===========================>
                SizedBox(height: 18.h),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgColorWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.google.svg(width: 40.w, height: 40.h),
                        const SizedBox(width: 8),
                        CustomText(
                          text: 'Sign in with Google',
                          color: AppColors.textColor000000,
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
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

                SizedBox(height: 70.h),
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
  final TextEditingController profileCtrl = TextEditingController();

  RxBool isChecked = false.obs;

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(.5),
      elevation: 3,
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            border: const Border(
              top: BorderSide(color: AppColors.primaryColorC79235, width: 0.25),
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 9.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 50.w),
                            CustomText(text: 'Gallery'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt, size: 50.w),
                            CustomText(text: 'Camera'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      Navigator.pop(context);
      selectedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      Navigator.pop(context);
      selectedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  String? selectedGender;
  File? selectedImage;
  String? profileImagePath;
}
