import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/controllers/bottom_nav_controller.dart';
import 'package:rabbit_hole_app/presentations/screens/home/home_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/leaderboard/leaderboard_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/profile_screen/profile_screen.dart';
import 'package:rabbit_hole_app/presentations/screens/shop_screen/shop_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavController _navController = Get.put(BottomNavController());

  final List<Widget> screens = [
    HomeScreen(),
    const LeaderBoardScreen(),
    const ShopScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Obx(() {
      final currentIndex = _navController.currentIndex.value;
      return Scaffold(
        backgroundColor:
            currentIndex == 0 ? Colors.transparent : AppColors.bgColorWhite,
        extendBody: true,
        body: IndexedStack(
          index: currentIndex,
          children: List.generate(
            screens.length,
            (i) => _navController.visitedTabs.contains(i)
                ? screens[i]
                : const SizedBox.shrink(),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: sizeH * .07,
            margin: EdgeInsets.all(sizeH * .015),
            padding: EdgeInsets.all(sizeH * .01),
            decoration: BoxDecoration(
              color: AppColors.decoColorE7F7FE,
              borderRadius: BorderRadius.circular(sizeH * .05),
              border: Border.all(color: AppColors.boxColorB59A2A),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, 0, sizeH),
                _buildNavItem(context, 1, sizeH),
                _buildNavItem(context, 2, sizeH),
                _buildNavItem(context, 3, sizeH),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(BuildContext context, int index, double sizeH) {
    final currentIndex = _navController.currentIndex.value;
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => _navController.switchTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: sizeH * .06,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.bottomColorB17D28 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: index == 0
              ? Assets.icons.home.svg(
                  color: isSelected
                      ? AppColors.bottomBackColorB3E5FC
                      : AppColors.textColor000000,
                )
              : index == 1
                  ? Assets.icons.scoreicon.svg(
                      color: isSelected
                          ? AppColors.bottomBackColorB3E5FC
                          : AppColors.textColor000000,
                    )
                  : index == 2
                      ? Assets.icons.shop.svg(
                          color: isSelected
                              ? AppColors.bottomBackColorB3E5FC
                              : AppColors.textColor000000,
                        )
                      : Assets.icons.nameProfile.svg(
                          color: isSelected
                              ? AppColors.bottomBackColorB3E5FC
                              : AppColors.textColor000000,
                        ),
        ),
      ),
    );
  }
}
