import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.bottomBackColorB3E5FC,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.r,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: 12.w),
            CustomText(
              text: "Settings",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// =================================> Audio Settings =============================>
            SizedBox(height: 16.h),
            Container(
              width: 346.w,
              height: 292.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.textColorFFFFFF,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1F000000),
                    offset: Offset(1.w, 3.h),
                    blurRadius: 4.r,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Assets.icons.statistics.svg(),
                      SizedBox(width: 8.w),
                      CustomText(
                        text: 'Audio Settings',
                        fontsize: 17.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor000000,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),


                ],
              ),
            ),



            SizedBox(height: 90.h)



          ],
        ),
      ),

    );
  }




}
