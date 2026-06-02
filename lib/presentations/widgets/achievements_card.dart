import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class AchievementsListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String name;
  final String subtitle;
  final VoidCallback? onTap;

  const AchievementsListCard({
    super.key,
    required this.imageUrl,
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
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Dynamic Image from URL
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: (imageUrl.isNotEmpty &&
                      (imageUrl.startsWith('http://') ||
                          imageUrl.startsWith('https://')))
                  ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: 42.w,
                height: 42.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.6),
                  highlightColor: Colors.grey.withOpacity(0.3),
                  child: Container(
                    width: 42.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    size: 24.sp,
                    color: Colors.grey[600],
                  ),
                ),
              )
                  : Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(Icons.emoji_events, size: 24.sp, color: Colors.grey[600]),
                    ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          text: title,
                          color: AppColors.textColor000000,
                          fontsize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8.w),
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
                      ),
                    ],
                  ),
                  CustomText(
                    text: name,
                    color: AppColors.textColor000000,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,
                    maxline: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}