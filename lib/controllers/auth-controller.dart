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

class AuthController extends GetxController {
  bool isChecked = false;
  bool isCheckboxError = false;
  RxBool isObscure = true.obs;
  RxBool isObscureConfirmPassword = true.obs;
  RxString loginError = ''.obs;
  RxString verifyError = ''.obs;
  RxString forgotError = ''.obs;
  RxString resetError = ''.obs;
  var logger = Logger();

  toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  RxBool signUpLoading = false.obs;

  ///========================================== Sing up ==================================<>

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
  }) async {
    List<MultipartBody> multipartBody =
        profileImage == null
            ? []
            : [MultipartBody("profileImage", profileImage)];

    signUpLoading(true);
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
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body["data"]["attributes"]["verificationToken"],
      );

      final token = response.body["data"]["attributes"]["verificationToken"];
      await PrefsHelper.setString(AppConstants.bearerToken, token);
      context.pushNamed(
        AppRoutes.verifyScreen,
        extra: {"screenType": "signup", "email": email, "token": token},
      );
      signUpLoading(false);
    } else {
      signUpLoading(false);
    }
  }

  ///========================================Verify Email===========================================<>
  RxBool verifyLoading = false.obs;

  verfyEmail(
    String otpCode,
    String email,
    String token, {
    String screenType = '',
    String type = '',
    required BuildContext context,
  }) async {
    verifyLoading(true);
    verifyError.value = '';
    var body = {"otp": otpCode, "email": email, "token": token};
    var response = await ApiClient.postData(
      ApiConstants.verifyEmailEndPoint,
      jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      verifyLoading(false);
      final accessToken =
          response.body["data"]["attributes"]["result"]["accessToken"];
      await PrefsHelper.setString(AppConstants.bearerToken, accessToken);

      if (type == 'Sign Up' && screenType == 'signup') {
        context.go(AppRoutes.signInScreen);
      } else if (type == 'Forgot' && screenType == 'forgot') {
        context.go(AppRoutes.resetPasswordScreen);
      }

      if (type == 'Sign Up') {
        if (screenType == 'signup') {
          context.go(AppRoutes.signInScreen);
        }
      } else {
        context.go(AppRoutes.resetPasswordScreen);
      }

      verifyLoading(false);
    } else {
      verifyLoading(false);
      verifyError.value = response.body["message"]?.toString() ?? 'Invalid OTP. Please try again.';
    }
  }

  ///============================================= Log in ===============================================<>
  RxBool logInLoading = false.obs;

  handleLogIn(
    String email,
    String password, {
    required BuildContext context,
  }) async {
    logInLoading.value = true;
    loginError.value = '';

    var headers = {'Content-Type': 'application/json'};
    var body = {"email": email, "password": password};

    var response = await ApiClient.postData(
      ApiConstants.loginUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    logInLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data']['attributes']["userWithoutPassword"];

      var token = response.body["data"]['attributes']["tokens"]["accessToken"];
      await PrefsHelper.setString(AppConstants.bearerToken, token);
      await PrefsHelper.setString(AppConstants.role, data['role']);

      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.userId, data['_id']);

      var role = data['role'];

      if (role == "user") {
        await PrefsHelper.setBool(AppConstants.isLogged, true);
        context.go(AppRoutes.bottomNavbarScreen);
      } else {
        final message = response.body["message"];
        loginError.value = message ?? 'Login failed. Please try again.';
      }
    } else if (response.statusCode == 1) {
      loginError.value = 'Server is offline. Please try later.';
    } else {
      final message = response.body["message"];
      loginError.value = message?.isNotEmpty == true
          ? message
          : 'Login failed. Please try again.';
    }
  }

  ///===========================================> Forgot Password ====================================================<>
  RxBool forgotLoading = false.obs;

  handleForgot(
    String email,
    screenType, {
    required BuildContext context,
  }) async {
    forgotLoading(true);
    forgotError.value = '';
    var body = {"email": email};
    var response = await ApiClient.postData(
      ApiConstants.forgotPasswordEndPoint,
      jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token =
          response.body["data"]["attributes"]["resetPasswordToken"] ??
          response.body["data"]["attributes"]["verificationToken"];
      if (token != null) {
        await PrefsHelper.setString(AppConstants.bearerToken, token);
      }

      if (screenType == "forgot") {
        context.pushNamed(
          AppRoutes.verifyScreen,
          extra: {"screenType": "forgot", "email": email, "token": token},
        );
      }

      forgotLoading(false);
    } else {
      forgotLoading(false);
      forgotError.value = response.body["message"]?.toString() ?? 'Something went wrong. Please try again.';
    }
  }

  ///===============Set Password================<>

  RxBool setPasswordLoading = false.obs;

  setPassword(
      String email,
      String password,
      String confirmpassword,
      {required BuildContext context}) async {
    setPasswordLoading(true);
    resetError.value = '';
    var body = {
      "email": email.toString().trim(),
      "password": password.toString().trim(),
      "confirmpassword": confirmpassword.toString().trim()
    };

    var response = await ApiClient.postData(
        ApiConstants.resetPasswordEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      context.go(AppRoutes.signInScreen);
      setPasswordLoading(false);
    } else {
      setPasswordLoading(false);
      resetError.value = response.body["message"]?.toString() ?? 'Failed to reset password. Please try again.';
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
      final newToken =
          attributes["resetPasswordToken"] ?? attributes["verificationToken"];

      if (newToken != null) {
        await PrefsHelper.setString(AppConstants.bearerToken, newToken);
      }

      return newToken;
    } else {
      return null;
    }
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

  ///===============Change Password================<>

  RxBool changePasswordLoading = false.obs;

  Future<bool> changePassword(String currentPassword, String password, String confirmPassword) async {
    changePasswordLoading(true);
    var body = {
      "currentPassword": currentPassword,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    var response =
        await ApiClient.postData(ApiConstants.changePassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      changePasswordLoading(false);
      return true;
    } else {
      changePasswordLoading(false);
      return false;
    }
  }
}
