import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import 'custom_profile_image.dart';
import 'custom_text.dart';

class GlobalListCard extends StatelessWidget {
  final Widget icon;
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const GlobalListCard({
    super.key,
    required this.icon,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 346.w,
        height: 75.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.textColorFFFFFF,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),

            /// Image + Name side by side
            Row(
              children: [
                CustomProfileImage(
                    imageUrl: imageUrl),
                SizedBox(width: 10.w),
                CustomText(
                  text: title,
                  color: AppColors.textColor000000,
                  fontsize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),

            const Spacer(),

            /// ====================================> Score  Label  ============================================>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: subtitle.split("\n")[0],
                  color: AppColors.textColor000000,
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: subtitle.split("\n")[1],
                  color: AppColors.textColor8A8A8A,
                  fontsize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
