import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../../core/constants/app_colors.dart';
import '../../../controllers/settings_controller.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {


  SettingsController controller = Get.put(SettingsController());

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.contactUs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.r),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: 12.w),
            CustomText(
              text: "Contact Us",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 130.h),
                    Center(
                      child: Assets.images.contactImage.image(
                        width: 257.w,
                        height: 230.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    CustomText(
                      text: 'If you face any kind of problem with our\n service feel free to contact us.',
                      color: AppColors.textColor000000,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        CustomText(
                          text: controller.contact.value?.phone ?? 'N/A',
                          color: AppColors.textColor000000,
                          fontWeight: FontWeight.w400,
                          fontsize: 16.sp,
                        ),
                        CustomText(
                          text: controller.contact.value?.email ?? 'N/A',
                          color: AppColors.textColor000000,
                          fontWeight: FontWeight.w400,
                          fontsize: 16.sp,
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
