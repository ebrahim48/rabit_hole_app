import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'custom_profile_image.dart';
import 'custom_text.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 393.w,
        height: 75.h,
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
          left: 24.w,
          right: 10.w,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFCCEEFD), // background color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left Section (Profile + Text)
            Row(
              children: [
                const CustomProfileImage(
                  imageUrl:
                  'https://media.licdn.com/dms/image/v2/C4E03AQGAvYAY6kdVXQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1603315936568?e=1758758400&v=beta&t=QeIvlqHz22MKUgXX6U56FSocAyZYGAA5NUi3CMb_alQ',
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Welcome, Ebrahim',
                      color: AppColors.textColor000000,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: 'Member since March 2024',
                      color: AppColors.textColor000000,
                      fontsize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),

            /// Right Section (Settings Icon)
            GestureDetector(
              onTap: () {

              },
              child: Assets.icons.settings.svg(
                width: 32.w,
                height: 32.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}