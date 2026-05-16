import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/auth-controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ChangePasswordModalContent extends StatefulWidget {
  final AuthController authController;

  const ChangePasswordModalContent({required this.authController});

  @override
  State<ChangePasswordModalContent> createState() => _ChangePasswordModalContentState();
}

class _ChangePasswordModalContentState extends State<ChangePasswordModalContent> {
  late final TextEditingController currentPassWordCtrl;
  late final TextEditingController newPassWordCtrl;
  late final TextEditingController confirmNewPassWordCtrl;
  late final GlobalKey<FormState> formKey;
  bool isMatched = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentPassWordCtrl = TextEditingController();
    newPassWordCtrl = TextEditingController();
    confirmNewPassWordCtrl = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    currentPassWordCtrl.dispose();
    newPassWordCtrl.dispose();
    confirmNewPassWordCtrl.dispose();
    super.dispose();
  }

  void _checkPasswordMatch() {
    setState(() {
      isMatched = newPassWordCtrl.text.isNotEmpty &&
          confirmNewPassWordCtrl.text.isNotEmpty &&
          newPassWordCtrl.text == confirmNewPassWordCtrl.text;
    });
  }

  Future<void> _handleSave() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final success = await widget.authController.changePassword(
          currentPassWordCtrl.text,
          newPassWordCtrl.text,
          confirmNewPassWordCtrl.text,
        );

        if (success && mounted) {
          Navigator.pop(context);
        }
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: 393.w,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: currentPassWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "Current Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22.h),
                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: newPassWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "New Password",
                  isPassword: true,
                  onChanged: (value) => _checkPasswordMatch(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    } else if (value == currentPassWordCtrl.text) {
                      return 'New password must be different';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  hintextColor: AppColors.textColor545454,
                  controller: confirmNewPassWordCtrl,
                  prefixIcon: Assets.icons.pass.svg(),
                  hintText: "Confirm New Password",
                  isPassword: true,
                  onChanged: (value) => _checkPasswordMatch(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    } else if (newPassWordCtrl.text != value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                if (isMatched)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w, top: 8.h),
                      child: CustomText(
                        text: 'Password Matched ✓',
                        color: Colors.green,
                        fontsize: 14.sp,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 8.h),
                SizedBox(height: 24.h),
                CustomButton(
                  loading: isLoading,
                  title: 'Save Change',
                  onpress: _handleSave,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}