import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../controllers/auth-controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'custom_pin_text_field.dart';

class VerifyScreen extends StatefulWidget {
  final String screenType;
  final String email;
  final String token;

  const VerifyScreen({
    super.key,
    required this.screenType,
    required this.email,
    required this.token

  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final AuthController authController = Get.put(AuthController());
  late final TextEditingController otpTEController;
  String _otpValue = '';

  late String currentToken;
  String _otpError = '';

  @override
  void initState() {
    super.initState();
    otpTEController = TextEditingController();
    currentToken = widget.token;
  }

  @override
  void dispose() {
    otpTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Verify',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 42.h),
              Center(
                  child: Assets.images.logo.image(
                      height: 100.h,
                      width: 100.w
                  )
              ),
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
                  CustomPinCodeTextField(
                      textEditingController: otpTEController,
                      onChanged: (value) {
                        setState(() {
                          _otpValue = value;
                        });
                      }
                  ),
                  SizedBox(height: 13.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        textAlign: TextAlign.center,
                        text: 'Didnt get the code?',
                      color: AppColors.textColor000000,
                        fontWeight: FontWeight.w400,
                        fontsize: 13.sp,
                      ),
                      Obx(() {
                        final isLoading = authController.resendLoading.value;
                        final isCounting = authController.isCountingDown.value;
                        final isDisabled = isLoading || isCounting;

                        return GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () async {
                            final newToken = await authController.reSendOtp(widget.email);
                            if (newToken != null && newToken.isNotEmpty) {
                              setState(() {
                                currentToken = newToken;
                              });
                            }
                            if (!authController.resendLoading.value) {
                              authController.startCountdown();
                            }
                          },
                          child:
                          CustomText(
                            fontWeight: FontWeight.w600,
                            text: isCounting
                                ? 'Resend in ${authController.countdown.value}s'
                                : 'Resend',
                            color: isDisabled
                                ? AppColors.secondary836531
                                : AppColors.textColor8C7720,
                            textDecoration: TextDecoration.underline,
                            fontsize: 14.sp,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 27.h),

              if (_otpError.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    _otpError,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),

              Obx(() {
                final serverError = authController.verifyError.value;
                return Column(
                  children: [
                    if (serverError.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          serverError,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    CustomButton(
                      loading: authController.verifyLoading.value,
                      title: "Verify",
                      onpress: () {
                        if (_otpValue.isEmpty) {
                          setState(() => _otpError = 'Please enter OTP');
                          return;
                        }
                        if (_otpValue.length != 6) {
                          setState(() => _otpError = 'Please enter valid 6-digit OTP');
                          return;
                        }
                        setState(() => _otpError = '');
                        authController.verfyEmail(
                          _otpValue,
                          widget.email,
                          currentToken,
                          screenType: widget.screenType,
                          type: widget.screenType == "signup" ? "Sign Up" : "Forgot",
                          context: context,
                        );
                      },
                    ),
                  ],
                );
              }),
              SizedBox(height: 27.h),
            ],
          ),
        ),
      ),
    );
  }
}