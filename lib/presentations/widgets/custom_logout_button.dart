import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

class CustomLogTwoButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const CustomLogTwoButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
      ),
      child: CustomText(
       text:  title,
        fontsize: 16.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}