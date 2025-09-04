import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'custom_text.dart';

class CarrotPacksCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback? onTap;

  const CarrotPacksCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 162.w,
        height: 162.h,
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🥕 Carrot icon
              Assets.icons.bigpacks.svg(),
              SizedBox(height: 7.h),
          
              /// 📦 Title & subtitle
              Column(
                children: [
                  CustomText(
                    text: title,
                    color: AppColors.textColor000000,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 7.h),
                  CustomText(
                    text: subtitle,
                    color: AppColors.textColor545454,
                    fontsize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
          
              /// 💰 Price button
              Container(
                width: 133.w,
                height: 35.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textColorFFD93B,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: CustomText(
                  text: price,
                  color: AppColors.textColor000000,
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
