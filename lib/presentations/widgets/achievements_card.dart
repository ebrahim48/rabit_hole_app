import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class AchievementsListCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String name;
  final String subtitle;
  final VoidCallback? onTap;

  const AchievementsListCard({
    super.key,
    required this.icon,
    required this.name,
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
          color: AppColors.bottomBackColorB3E5FC,
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
            SizedBox(width: 15.w),

            ///  Name side by side
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: title,
                      color: AppColors.textColor000000,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(width: 20.h),
                    Container(
                      width: 84.w,
                      height: 20.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7FA3B3).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: CustomText(
                        text: subtitle,
                        color: AppColors.textColor000000,
                        fontsize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )

                  ],
                ),
                CustomText(
                  text: name,
                  color: AppColors.textColor000000,
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
