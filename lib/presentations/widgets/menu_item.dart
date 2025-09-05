import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'custom_text.dart';

class MenuItemWidget extends StatelessWidget {
  final dynamic icon;
  final String text;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
             SizedBox(width: 21.h),
            CustomText(text:
            text,
              fontsize: 16.h,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor000000,
            ),
          ],
        ),
        Assets.icons.arrow.svg(),
      ],
    );
  }
}