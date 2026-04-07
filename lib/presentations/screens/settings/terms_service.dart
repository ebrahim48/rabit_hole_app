import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../controllers/settings_controller.dart';
import '../../widgets/custom_text.dart';

class TermsServiceScreen extends StatefulWidget {
  const TermsServiceScreen({super.key});

  @override
  State<TermsServiceScreen> createState() => _TermsServiceScreenState();
}

class _TermsServiceScreenState extends State<TermsServiceScreen> {
  SettingsController controller = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.termsCondition();
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
              text: "Terms of Service",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Our Terms of Services",
                  fontsize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor4E4E4E,
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.textColorE7F7FE,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.textColor89611F),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Obx(() {
                    if (controller.getTermsConditionLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Html(
                      data: controller.terms.value.isEmpty
                          ? '<p>No content available.</p>'
                          : controller.terms.value,
                      style: {
                        "body": Style(
                          fontSize: FontSize(13.sp),
                          color: AppColors.textColor4E4E4E,
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                        "p": Style(
                          fontSize: FontSize(13.sp),
                          color: AppColors.textColor4E4E4E,
                        ),
                      },
                    );
                  }),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
