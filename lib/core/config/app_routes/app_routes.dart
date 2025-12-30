import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/presentations/screens/auth/register_screen/register_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/home_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/leaderboard/leaderboard_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/profile_screen/update_profile_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/profile_screen/profile_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/contact_us_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/privacy_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/settings_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/settings/terms_service.dart';
import 'package:rabbit_hole_app/presentations/screens/shop_screen/shop_screen.dart';

import '../../../helpers/prefs_helper.dart';
import '../../../presentations/screens/auth/forget_screen/forget_screen.dart';
import '../../../presentations/screens/auth/reset_screen/reset_screen.dart';
import '../../../presentations/screens/auth/verify_screen/verify_screen.dart';
import '../../../presentations/screens/profile_screen/edit_profile_screen.dart';
import '../../../presentations/screens/settings/about_us_screen.dart';
import '../../../presentations/screens/splash/splash_screen.dart';
import '../../app_constants/app_constants.dart';

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
  static const String updateProfileScreen = "/updateProfileScreen";
  static const String settingsScreen = "/settingsScreen";
  static const String privacyScreen = "/privacyScreen";
  static const String termsServiceScreen = "/termsServiceScreen";
  static const String aboutUsScreen = "/aboutUsScreen";
  static const String gameScreen = "/gameScreen";
  static const String contactUsScreen = "/contactUsScreen";

  static final GoRouter goRouter = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        name: splashScreen,
        builder: (context, state) => const SplashScreen(),
        // redirect: (context, state) {
        //   Future.delayed(const Duration(seconds: 3), () async {
        //     var token = await PrefsHelper.getString(AppConstants.bearerToken);
        //     if (token != "") {
        //       AppRoutes.goRouter.replaceNamed(AppRoutes.bottomNavbarScreen);
        //     }
        //   });
        //
        //   return;
        // },
      ),

      GoRoute(
        path: registerScreen,
        name: registerScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(RegisterScreen(), state),
      ),
      // GoRoute(
      //   path: onBoardingScreen,
      //   name: onBoardingScreen,
      //   pageBuilder: (context, state) =>
      //       _customTransitionPage((), state),
      // ),
      GoRoute(
        path: signInScreen,
        name: signInScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(SignInScreen(), state),
      ),

      GoRoute(
        path: forgetPasswordScreen,
        name: forgetPasswordScreen,
        builder: (context, state) {
          String email = state.extra as String;
          return ForgetPasswordScreen(email: email);
        },
      ),

      GoRoute(
        path: verifyScreen,
        name: verifyScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final screenType = extra['screenType']?.toString() ?? '';
          final email = extra['email']?.toString() ?? '';
          final token = extra['token']?.toString() ?? '';
          return VerifyScreen(
            screenType: screenType,
            email: email,
            token: token,
          );
        },
      ),

      GoRoute(
        path: resetPasswordScreen,
        name: resetPasswordScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String?;

          return ResetPasswordScreen(email: email);
        },
      ),

      GoRoute(
        path: homeScreen,
        name: homeScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(HomeScreen(), state),
      ),

      GoRoute(
        path: gameScreen,
        name: gameScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(GameScreen(), state),
      ),

      GoRoute(
        path: bottomNavbarScreen,
        name: bottomNavbarScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(BottomNavBar(), state),
      ),

      GoRoute(
        path: leaderBoardScreen,
        name: leaderBoardScreen,
        pageBuilder:
            (context, state) =>
                _customTransitionPage(const LeaderBoardScreen(), state),
      ),

      GoRoute(
        path: shopScreen,
        name: shopScreen,
        pageBuilder:
            (context, state) =>
                _customTransitionPage(const ShopScreen(), state),
      ),

      GoRoute(
        path: profileScreen,
        name: profileScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(ProfileScreen(), state),
      ),

      GoRoute(
        path: updateProfileScreen,
        name: updateProfileScreen,
        pageBuilder:
            (context, state) =>
                _customTransitionPage(UpdateProfileScreen(), state),
      ),


      GoRoute(
        path: editProfileScreen,
        name: editProfileScreen,
        pageBuilder:
            (context, state) =>
                _customTransitionPage(EditProfileScreen(), state),
      ),

      GoRoute(
        path: settingsScreen,
        name: settingsScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(SettingsScreen(), state),
      ),

      GoRoute(
        path: privacyScreen,
        name: privacyScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(PrivacyScreen(), state),
      ),
      GoRoute(
        path: termsServiceScreen,
        name: termsServiceScreen,
        pageBuilder:
            (context, state) =>
                _customTransitionPage(TermsServiceScreen(), state),
      ),

      GoRoute(
        path: aboutUsScreen,
        name: aboutUsScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(AboutUsScreen(), state),
      ),

      GoRoute(
        path: contactUsScreen,
        name: contactUsScreen,
        pageBuilder:
            (context, state) => _customTransitionPage(ContactUsScreen(), state),
      ),
    ],
  );

  static Page<dynamic> _customTransitionPage(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
