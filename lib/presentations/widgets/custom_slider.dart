import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/controllers/settings_controller.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

import '../../core/constants/app_colors.dart';
import 'custom_thumber.dart';

class CustomSoundSlider extends StatefulWidget {
  const CustomSoundSlider({super.key});

  @override
  State<CustomSoundSlider> createState() => _CustomSoundSliderState();
}

class _CustomSoundSliderState extends State<CustomSoundSlider> {
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
                text: "Volume",
                fontsize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor545454,
              ),
              CustomText(
                text: "${(controller.soundEffectsVolume.value * 100).round()}%",
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
              value: controller.soundEffectsVolume.value,
              onChanged: (val) {
                controller.setSoundEffectsVolume(val);
              },
            ),
          ),
        ],
      );
    });
  }
}