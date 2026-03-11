import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/controllers/settings_controller.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

import '../../core/constants/app_colors.dart';
import 'custom_thumber.dart';

class CustomFeedbackSlider extends StatefulWidget {
  const CustomFeedbackSlider({super.key});

  @override
  State<CustomFeedbackSlider> createState() => _CustomFeedbackSliderState();
}

class _CustomFeedbackSliderState extends State<CustomFeedbackSlider> {
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          /// Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Touch Sensitivity",
                fontsize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor545454,
              ),
              CustomText(
                text: "${(controller.hapticFeedbackIntensity.value * 100).round()}%",
                fontsize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor000000,
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Custom Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              trackShape: const RoundedRectSliderTrackShape(),
              activeTrackColor: const Color(0xFFF9B039),
              inactiveTrackColor: Color(0xFFD3B0B0),
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape: CustomCircleThumb(),
            ),
            child: Slider(
              value: controller.hapticFeedbackIntensity.value,
              onChanged: (val) {
                controller.setHapticFeedbackIntensity(val);
              },
            ),
          ),
        ],
      );
    });
  }
}