import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/presentations/screens/auth/register_screen/register_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/home_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/leaderboard/leaderboard_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/profile_screen/edit_profile_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/profile_screen/profile_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/contact_us_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/privacy_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/settings_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/terms_service.dart';
import 'package:rabbit_hole_app/presentations/screens/shop_screen/shop_screen.dart';

import '../../../presentations/screens/auth/forget_screen/forget_screen.dart';
import '../../../presentations/screens/auth/reset_screen/reset_screen.dart';
import '../../../presentations/screens/auth/verify_screen/verify_screen.dart';
import '../../../presentations/screens/settings/about_us_screen.dart';
import '../../../presentations/screens/splash/splash_screen.dart';



class AppRoutes {

  static const String splashScreen = "/splashScreen";
  static const String onBoardingScreen = "/onBoardingScreen";

  /// =============================> Auth ================================>

  static const String registerScreen = "/registerScreen";
  static const String signInScreen = "/signInScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyScreen = "/verifyScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";

  /// ============================> Home ================================>

  static const String homeScreen = "/homeScreen";
  static const String bottomNavbarScreen = "/bottomNavbarScreen";
  static const String leaderBoardScreen = "/leaderBoardScreen";
  static const String shopScreen = "/shopScreen";
  static const String profileScreen = "/profileScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String settingsScreen = "/settingsScreen";
  static const String privacyScreen = "/privacyScreen";
  static const String termsServiceScreen = "/termsServiceScreen";
  static const String aboutUsScreen = "/aboutUsScreen";
  static const String gameScreen = "/gameScreen";
  static const String contactUsScreen = "/contactUsScreen";


  static final GoRouter goRouter =
  GoRouter(initialLocation: splashScreen, routes: [


    GoRoute(
      path: splashScreen,
      name: splashScreen,
      builder: (context, state) => const SplashScreen(),
      redirect: (context, state) {
        Future.delayed(const Duration(seconds: 3), () async {
          // var role = await PrefsHelper.getString(AppConstants.role);
          // var token = await PrefsHelper.getString(AppConstants.bearerToken);
          // var userId = await PrefsHelper.getString(AppConstants.userId);
          // var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
          // bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
          //
          //
          //
          // print("======================================$isLogged  \n token: $token \n userId : $userId \n fcm token : $fcmToken");
          //
          // SocketServices sockService = SocketServices();
          //
          // sockService.init(userId: userId, fcmToken: fcmToken.toString());
          // FirebaseNotificationService.listenMessage();
          //
          // if(token != "" && isLogged){
          //
          //   /// ===============Role Check =============>>>
          //   if(role.toLowerCase() == "customer"){
          //     AppRoutes.goRouter.replaceNamed(AppRoutes.customerBottomNavBar);
          //   }else if(role.toLowerCase() == "mechanic"){
          //     AppRoutes.goRouter.replaceNamed(AppRoutes.mechanicBottomNavBar);
          //   }else{
          //     AppRoutes.goRouter.replaceNamed(AppRoutes.towTruckBottomNavBar);
          //   }
          // }else{
          //   AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
          // }
          // AppRoutes.goRouter.replaceNamed(AppRoutes.onBoardingScreen);

        }

        );

        return;
      },
    ),

    // ///<<<=============>>> ONBOARDING SCREEN <<<===============>>>
    // GoRoute(
    //   path: onBoardingScreen,
    //   name: onBoardingScreen,
    //   pageBuilder: (context, state) =>
    //       _customTransitionPage(OnboardingScreen(), state),
    // ),
    // /// =============================================================> Auth  =================================================>
    //
    ///<<<=============>>> Sign Up SCREEN <<<===============>>>
    GoRoute(
      path: registerScreen,
      name: registerScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(RegisterScreen(), state),
    ),
    ///<<<=============>>> Log In <<<===============>>>
    GoRoute(
      path: signInScreen,
      name: signInScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(SignInScreen(), state),
    ),

    ///<<<=============>>> Forget Password Screen  <<<===============>>>
    GoRoute(
      path: forgetPasswordScreen,
      name: forgetPasswordScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ForgetPasswordScreen(), state),
    ),


    ///<<<=============>>> Verify Screen  <<<===============>>>
    GoRoute(
      path: verifyScreen,
      name: verifyScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(VerifyScreen(), state),
    ),


    ///<<<=============>>> Reset Password Screen  <<<===============>>>
    GoRoute(
      path: resetPasswordScreen,
      name: resetPasswordScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ResetPasswordScreen(), state),
    ),

    ///<<<=============>>> Home Screen  <<<===============>>>
    GoRoute(
      path: homeScreen,
      name: homeScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(HomeScreen(), state),
    ),

    ///<<<=============>>> Game Screen  <<<===============>>>
    GoRoute(
      path: gameScreen,
      name: gameScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(GameScreen(), state),
    ),



    ///<<<=============>>> Bottom Navbar  Screen  <<<===============>>>
    GoRoute(
      path: bottomNavbarScreen,
      name: bottomNavbarScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(BottomNavBar(), state),
    ),

    ///<<<=============>>> Leader Board  Screen  <<<===============>>>
    GoRoute(
      path: leaderBoardScreen,
      name: leaderBoardScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(const LeaderBoardScreen(

          ), state),
    ),
    ///<<<=============>>> Shop  Screen  <<<===============>>>
    GoRoute(
      path: shopScreen,
      name: shopScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(const ShopScreen(
          ), state),
    ),


    ///<<<=============>>> Profile  Screen  <<<===============>>>
    GoRoute(
      path: profileScreen,
      name: profileScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ProfileScreen(), state),
    ),



    ///<<<=============>>> Edit Profile  Screen  <<<===============>>>
    GoRoute(
      path: editProfileScreen,
      name: editProfileScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage( EditProfileScreen(), state),
    ),

    ///<<<=============>>> Edit Profile  Screen  <<<===============>>>
    GoRoute(
      path: settingsScreen,
      name: settingsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage( SettingsScreen(), state),
    ),



    ///<<<=============>>> Privacy Policy Screen  <<<===============>>>
    GoRoute(
      path: privacyScreen,
      name: privacyScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(PrivacyScreen(), state),
    ),
    ///<<<=============>>> Terms Services Screen  <<<===============>>>
    GoRoute(
      path: termsServiceScreen,
      name: termsServiceScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TermsServiceScreen(), state),
    ),

    //<<<=============>>>  About  Screen  <<<===============>>>
    GoRoute(
      path: aboutUsScreen,
      name: aboutUsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(AboutUsScreen(), state),
    ),
    //<<<=============>>>  Contact Us  Screen  <<<===============>>>
    GoRoute(
      path: contactUsScreen,
      name: contactUsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ContactUsScreen(), state),
    ),



  ]);





  static Page<dynamic> _customTransitionPage(
      Widget child, GoRouterState state) {

    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
