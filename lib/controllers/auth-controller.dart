import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import '../../core/app_constants/app_constants.dart';
import '../../core/config/app_routes/app_routes.dart';
import '../../core/helpers/prefs_helper.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../helpers/toast_message_helper.dart';




class AuthController extends GetxController {

  bool isChecked = false;
  bool isCheckboxError = false;
  RxBool isObscure = true.obs;
  RxBool isObscureConfirmPassword = true.obs;
  var logger = Logger();

  toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }



  ///========================================== Sign up ==================================<>
  RxBool signUpLoading = false.obs;
  RxString signUpEmailError = ''.obs;
  RxString signUpPhoneError = ''.obs;
  RxString signUpError = ''.obs;
  handleSignUp({
    String? email,
    fullName,
    password,
    phone,
    address,
    File? profileImage,
    confirmpassword,
    required BuildContext context,
    required String screenType,
    GlobalKey<FormState>? formKey,
  }) async {

    List<MultipartBody> multipartBody =
    profileImage == null ? [] : [MultipartBody("profileImage", profileImage)];

    signUpLoading(true);
    signUpEmailError.value = '';
    signUpPhoneError.value = '';

    var body = {
      "email": "$email",
      "phone": "$phone",
      "address": "$address",
      "fullName": "$fullName",
      "password": "$password",
      "confirmpassword": "$confirmpassword",
    };

    var response = await ApiClient.postMultipartData(
      ApiConstants.signUpEndPoint,
      body,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = response.body["data"]["attributes"]["verificationToken"];
      await PrefsHelper.setString(AppConstants.bearerToken, token);

      context.pushNamed(
        AppRoutes.verifyScreen,
        extra: {
          "screenType": "signup",
          "email": email,
          "token": token,
        },
      );
      signUpLoading(false);
    } else {
      signUpLoading(false);

      final message = (response.body["message"] ?? "").toString();

      if (message.toLowerCase().contains("phone")) {
        signUpPhoneError.value = message;
      } else if (message.toLowerCase().contains("email")) {
        signUpEmailError.value = message;
      }

      // error set হওয়ার পরে form revalidate
      Future.delayed(Duration.zero, () => formKey?.currentState?.validate());
    }
  }
  // handleSignUp(
  //     {String?
  //       email,
  //       fullName,
  //       password,
  //       phone,
  //       address,
  //       File? profileImage,
  //       confirmpassword,
  //       required BuildContext context,
  //       required String screenType}) async {
  //
  //   List<MultipartBody> multipartBody =
  //   profileImage == null ? [] : [MultipartBody("profileImage", profileImage)];
  //
  //   signUpLoading(true);
  //   var body = {
  //     "email": "$email",
  //     "phone": "$phone",
  //     "address": "$address",
  //     "fullName": "$fullName",
  //     "password": "$password",
  //     "confirmpassword": "$confirmpassword",
  //   };
  //
  //   var response = await ApiClient.postMultipartData(
  //     ApiConstants.signUpEndPoint,
  //       body,
  //       multipartBody: multipartBody
  //   );
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     await PrefsHelper.setString(AppConstants.bearerToken,
  //         response.body["data"]["attributes"]["verificationToken"]);
  //
  //     final token = response.body["data"]["attributes"]["verificationToken"];
  //     await PrefsHelper.setString(AppConstants.bearerToken, token);
  //     context.pushNamed(
  //       AppRoutes.verifyScreen,
  //       extra: {
  //         "screenType": "signup",
  //         "email": email,
  //         "token": token,
  //       },
  //     );
  //     // ToastMessageHelper.showToastMessage("User created successfully, please verify your email");
  //     signUpLoading(false);
  //   } else {
  //     // ToastMessageHelper.showToastMessage(
  //     //     "${response.body["message"]}", title: 'Fail');
  //     signUpLoading(false);
  //   }
  // }


  ///========================================Verify Email===========================================<>
  RxBool verifyLoading = false.obs;

  verfyEmail(String otpCode, String email, String token,
      {String screenType = '', String type = '', required BuildContext context}) async {
    verifyLoading(true);
    var body = {
      "otp": otpCode,
      "email": email,
      "token": token
    };
    var response = await ApiClient.postData(
        ApiConstants.verifyEmailEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      verifyLoading(false);
      final accessToken = response
          .body["data"]["attributes"]["result"]["accessToken"];
      await PrefsHelper.setString(AppConstants.bearerToken, accessToken);
      if (type == 'Sign Up' && screenType == 'signup') {
        context.go(AppRoutes.signInScreen);
        // ToastMessageHelper.showToastMessage("${response.body["message"]}", title: 'Success');
      } else if (type == 'Forgot' && screenType == 'forgot') {
        context.go(
            AppRoutes.resetPasswordScreen,
            extra: {'email': email}
        );
        // ToastMessageHelper.showToastMessage("OTP verified! Now reset your password", title: 'Success');
      } else {
        if (screenType == 'signup') {
          context.go(AppRoutes.signInScreen);
        } else {
          context.go(
              AppRoutes.resetPasswordScreen,
              extra: {'email': email}
          );
        }
        // ToastMessageHelper.showToastMessage("${response.body["message"]}", title: 'Success');
      }

      verifyLoading(false);
    } else {
      verifyLoading(false);
      ToastMessageHelper.showToastMessage("${response.body["message"]}", title: 'attention');
      print('================================ Verify failed for screenType: $screenType');
    }
  }



  // ///========================================Verify Email===========================================<>
  // RxBool verifyLoading = false.obs;
  //
  // verfyEmail(String otpCode, String email, String token,
  //     {String screenType = '', String type = '', required BuildContext context}) async {
  //   verifyLoading(true);
  //   var body = {
  //     "otp": otpCode,
  //     "email": email,
  //     "token": token
  //   };
  //   var response = await ApiClient.postData(
  //       ApiConstants.verifyEmailEndPoint, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     verifyLoading(false);
  //     final accessToken = response
  //         .body["data"]["attributes"]["result"]["accessToken"];
  //     await PrefsHelper.setString(AppConstants.bearerToken, accessToken);
  //
  //
  //
  //     if (type == 'Sign Up' && screenType == 'signup') {
  //       context.go(AppRoutes.signInScreen);
  //     } else if (type == 'Forgot' && screenType == 'forgot') {
  //       context.go(AppRoutes.resetPasswordScreen);
  //     }
  //
  //     if (type == 'Sign Up') {
  //       print('================================ screenType received yjuikhujikgyhujvghg: $screenType');
  //       if(screenType== 'signup'){
  //         context.go(AppRoutes.signInScreen);
  //       }
  //     }else{
  //       context.go(AppRoutes.resetPasswordScreen);
  //     }
  //
  //
  //     verifyLoading(false);
  //     ToastMessageHelper.showToastMessage("${response.body["message"]}",title: 'Success');
  //   } else {
  //     verifyLoading(false);
  //     ToastMessageHelper.showToastMessage("${response.body["message"]}", title: 'attention');
  //     print(
  //         '================================ screenType received yjuikhujikgyhujvghg: $screenType');
  //   }
  // }


  ///============================================= Log in ===============================================<>
  RxBool logInLoading = false.obs;
  RxString loginError = ''.obs;

  handleLogIn(String email, String password, {required BuildContext context}) async {
    logInLoading.value = true;
    loginError.value = '';

    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "password": password,
    };

    var response = await ApiClient.postData(
      ApiConstants.loginUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    logInLoading.value = false;

    print("========================${response.statusCode} \n ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data']['attributes']["userWithoutPassword"];

      logger.d("token  .....");
      var token = response.body["data"]['attributes']["tokens"]["accessToken"];
      logger.d("token   .... ======>> $token");
      await PrefsHelper.setString(AppConstants.bearerToken, token);
      await PrefsHelper.setString(AppConstants.role, data['role']);

      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.userId, data['_id']);

      var role = data['role'];
      print("========================================= role : $role");

      if (role == "user") {
        await PrefsHelper.setBool(AppConstants.isLogged, true);
        context.go(AppRoutes.bottomNavbarScreen);
      } else {
        final message = response.body["message"];
        loginError.value = message ?? "Access denied";
      }
    } else {
      final message = response.body["message"];

      if (message == "Email not verified. Please verify your email.") {
        loginError.value = "Email not verified. Please verify your email.";
      } else if (message == "⛔ Wrong password! ⛔") {
        loginError.value = "Wrong password. Please try again.";
      } else {
        loginError.value = message ?? "Account not found. Please register.";
      }
    }
  }





  // RxBool logInLoading = false.obs;
  //
  // handleLogIn(String email,
  //     String password,
  //     {required BuildContext context}) async {
  //   logInLoading.value = true;
  //
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = {
  //     "email": email,
  //     "password": password,
  //   };
  //
  //   var response = await ApiClient.postData(
  //     ApiConstants.loginUpEndPoint,
  //     jsonEncode(body),
  //     headers: headers,
  //   );
  //
  //   logInLoading.value = false;
  //
  //   print("========================${response.statusCode} \n ${response.body}");
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data = response.body['data']['attributes']["userWithoutPassword"];
  //
  //
  //     logger.d("token  .....");
  //     /// Access token save
  //     var token=response.body["data"]['attributes']["tokens"]["accessToken"];
  //     logger.d("token   .... ======>> $token");
  //     await PrefsHelper.setString(AppConstants.bearerToken, token,
  //     );
  //     await PrefsHelper.setString(AppConstants.role, data['role']);
  //
  //     /// Save user details
  //     await PrefsHelper.setString(AppConstants.email, email);
  //     await PrefsHelper.setString(AppConstants.userId, data['_id']);
  //
  //     var role = data['role'];
  //     print("========================================= role : $role");
  //
  //     if (role == "user") {
  //       await PrefsHelper.setBool(AppConstants.isLogged, true);
  //       context.go(AppRoutes.bottomNavbarScreen);
  //     } else {
  //       final message = response.body["message"];
  //
  //       if (message == "Email not verified. Please verify your email.") {
  //         final verificationToken = response.body["data"]['attributes']["tokens"]["accessToken"];
  //
  //         await PrefsHelper.setString(AppConstants.bearerToken, verificationToken);
  //
  //         ToastMessageHelper.showToastMessage(
  //           "We've sent an OTP to your email. Please verify your email.",
  //         );
  //       } else if (message == "⛔ Wrong password! ⛔") {
  //         ToastMessageHelper.showToastMessage(message);
  //       } else {
  //         ToastMessageHelper.showToastMessage(
  //           message,
  //           title: 'attention',
  //         );
  //       }
  //     }
  //
  //   }
  // }


  ///===========================================> Forgot Password ====================================================<>
  RxBool forgotLoading = false.obs;

  handleForgot(String email, screenType,
      {required BuildContext context}) async {
    forgotLoading(true);
    var body = {"email": email};
    var response = await ApiClient.postData(
      ApiConstants.forgotPasswordEndPoint,
      jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = response.body["data"]["attributes"]["resetPasswordToken"] ??
          response.body["data"]["attributes"]["verificationToken"];
      if (token != null) {
        await PrefsHelper.setString(AppConstants.bearerToken, token);
      } else {
        debugPrint("❌ Token missing in forgot response.");
      }

      if (screenType == "forgot") {
        context.pushNamed(AppRoutes.verifyScreen, extra: {
          "screenType": "forgot",
          "email": email,
          "token": token,
        });
      }

      forgotLoading(false);
    } else {
      forgotLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"]);
    }
  }


  RxBool setPasswordLoading = false.obs;

  setPassword(
      String email,
      String password,
      String confirmpassword, {
        required BuildContext context
      }) async {
    setPasswordLoading(true);

    var body = {
      "password": password.trim(),
      "email": email.trim(),
      "confirmpassword": confirmpassword.trim()
    };

    var response = await ApiClient.postData(
        ApiConstants.resetPasswordEndPoint,
        jsonEncode(body)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      context.go(AppRoutes.signInScreen);
      // ToastMessageHelper.showToastMessage(
      //     'Password reset successfully! Please login',
      //     title: 'success'
      // );
      setPasswordLoading(false);
    } else if (response.statusCode == 1) {
      setPasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      setPasswordLoading(false);
      ToastMessageHelper.showToastMessage(
          '${response.body["message"]}',
          title: 'attention'
      );
    }
  }
  ///===============Change Password================<>
  RxBool changePasswordLoading = false.obs;

  changePassword(String currentPassword, String newPassword) async {
    changePasswordLoading(true);

    var body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };

    var response = await ApiClient.postData(
        ApiConstants.changePassword,
        jsonEncode(body)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // ToastMessageHelper.showToastMessage('Password Changed Successfully');
      changePasswordLoading(false);
      return true; // Success indicator
    } else if (response.statusCode == 1) {
      changePasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
      return false;
    } else {
      ToastMessageHelper.showToastMessage(response.body['message'],title: 'error');
      changePasswordLoading(false);
      return false;
    }
  }


  ///===============Resend================<>


  RxBool resendLoading = false.obs;

  Future<String?> reSendOtp(String email) async {
    resendLoading(true);

    String token = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var body = {"email": email};

    var response = await ApiClient.postData(
      ApiConstants.resendOtpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    resendLoading(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final attributes = response.body["data"]["attributes"];
      final newToken = attributes["resetPasswordToken"] ?? attributes["verificationToken"];

      if (newToken != null) {
        await PrefsHelper.setString(AppConstants.bearerToken, newToken);
        logger.d("✅ New token saved: $newToken");
        // ToastMessageHelper.showToastMessage("✅ OTP sent successfully to your email.");
        return newToken;
      }
    } else {
      ToastMessageHelper.showToastMessage(
        response.body["message"] ?? "❌ Failed to resend OTP",
        title: "Error",
      );
    }

    return null;
  }
  final RxInt countdown = 60.obs;
  final RxBool isCountingDown = false.obs;
  Timer? _timer;

  void startCountdown() {
    isCountingDown.value = true;
    countdown.value = 60;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isCountingDown.value = false;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}










