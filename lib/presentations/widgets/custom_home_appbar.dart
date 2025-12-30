import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import '../../controllers/profile_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'custom_profile_image.dart';
import 'custom_text.dart';
import 'package:intl/intl.dart';

class CustomHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProfile();
    });
  }


  String getFormattedDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('MMMM d, yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 393.w,
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
        decoration: const BoxDecoration(
          color: Color(0xFFCCEEFD),
        ),
        child: Obx(() {

          final formattedDate = getFormattedDate(controller.profile.value?.createdAt);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left Section (Profile + Text)
              Expanded(
                child: Row(
                  children: [
                    CustomProfileImage(
                        imageUrl: controller.profile.value.profileImage ?? ''
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: controller.profile.value.fullName ?? 'Loading...',
                            color: AppColors.textColor000000,
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w500,
                            maxline: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text: 'Member Since: $formattedDate',
                            color: AppColors.textColor000000,
                            fontsize: 11.sp,
                            fontWeight: FontWeight.w400,
                            maxline: 1,
                            textOverflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// Right Section (Settings Icon)
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.settingsScreen);
                },
                child: Assets.icons.settings.svg(
                    width: 32.w,
                    height: 32.h
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}