import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'custom_text.dart';

class PowerUpsListCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String name;
  final String price;
  final VoidCallback? onTap;

  const PowerUpsListCard({
    super.key,
    required this.icon,
    required this.name,
    required this.title,
    required this.price,
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
            SizedBox(width: 15.w),

            ///  Name side by side
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.textColor000000,
                  fontsize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: name,
                  color: AppColors.textColor000000,
                  fontsize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),

            const Spacer(),

            /// ====================================> Score  Label  ============================================>
            Container(
              width: 100.w,
              height: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.textColorFFD93B,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Assets.icons.bigpacks.svg(),
                  ),
                  // Price text
                  CustomText(
                    text: price,
                    color: AppColors.textColor000000,
                    fontsize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
