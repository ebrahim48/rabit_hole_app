import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

import '../../core/constants/app_colors.dart';
import 'custom_thumber.dart';

class CustomMusicSlider extends StatefulWidget {
  const CustomMusicSlider({super.key});

  @override
  State<CustomMusicSlider> createState() => _CustomMusicSliderState();
}

class _CustomMusicSliderState extends State<CustomMusicSlider> {
  double musicVolume = 0.83;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: "Volume",
              fontsize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor545454,),
            CustomText(text: "${(musicVolume * 100).round()}%",
                fontsize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor000000),
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
            thumbShape:  CustomCircleThumb(), // custom circle
          ),
          child: Slider(
            value: musicVolume,
            onChanged: (val) {
              setState(() => musicVolume = val);
            },
          ),
        ),
      ],
    );
  }
}