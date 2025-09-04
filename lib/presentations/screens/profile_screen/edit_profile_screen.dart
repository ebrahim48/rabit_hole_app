import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_button.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_main_profile.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
              text: "Edit Profile",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: IconButton(
              onPressed: () {},
              icon: Assets.icons.settings.svg(),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomMainProfileImage(
                  imageUrl: 'https://media.licdn.com/dms/image/v2/C4E03AQGAvYAY6kdVXQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1603315936568?e=1758758400&v=beta&t=QeIvlqHz22MKUgXX6U56FSocAyZYGAA5NUi3CMb_alQ',
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Input fields box
            Container(
              width: 393.w,
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.textColorFFFFFF,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  // Name
                  CustomText(
                    text: "Name",
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    initialValue: "Jessika",
                    style: const TextStyle(color: AppColors.textColor545454),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.textColorC7A8AD),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Address
                  CustomText(text: "Address",
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,),
                  SizedBox(height: 8.h),
                  TextFormField(
                    initialValue: "2431 AF AMSTERDAM",
                    style: const TextStyle(color: AppColors.textColor545454),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: AppColors.textColorC7A8AD),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Phone
                  CustomText(text: "Phone", color: AppColors.textColor545454,
                      fontsize: 13.sp,
                      fontWeight: FontWeight.w400),
                  SizedBox(height: 8.h),
                  TextFormField(
                    initialValue: "************",
                    style: const TextStyle(color: AppColors.textColor545454),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: AppColors.textColorC7A8AD),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    ),
                  ),
                  SizedBox(height: 310.h),
                 CustomButton(
                   title: 'Save Change',
                     onpress: () {

                     },),

                ],
              ),
            ),




          ],
        ),
      ),
    );
  }

  TextEditingController namCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
}
