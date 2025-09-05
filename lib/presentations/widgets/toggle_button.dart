import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../core/constants/app_colors.dart';
import 'custom_text.dart';


class ToggleButtonWidget extends StatelessWidget {
  const ToggleButtonWidget({
    super.key,
    required this.status,
    required this.onToggle,

    this.activeColor,
    this.borderColor,
  });

  final bool status;
  final Function(bool) onToggle;

  final Color? activeColor;
  final Color? borderColor;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              )
            ],
          ),
          child: Container(
            height: 34.h,
            width: 64.w,
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                color: AppColors.bottomBackColorB3E5FC,
                width: 2.5.w,
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: FlutterSwitch(
              width: 53.w,
              height: 28.h,
              toggleSize: 20.r,
              toggleColor: AppColors.textColorFFFFFF,
              activeColor: activeColor ?? AppColors.textColorFFFFFF,
              inactiveColor: AppColors.textColor545454,
              value: status,
              borderRadius: 100.r,
              padding: 1.5.w,
              onToggle: onToggle,
              showOnOff: false,
            ),
          ),
        ),
      ],
    );
  }
}
