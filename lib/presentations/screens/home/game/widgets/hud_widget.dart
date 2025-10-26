
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/global/custom_assets/assets.gen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

class HudWidget extends StatefulWidget {
  final RabbitGame game;

  const HudWidget({super.key, required this.game});

  @override
  State<HudWidget> createState() => _HudWidgetState();
}

class _HudWidgetState extends State<HudWidget> {
  late int carrots;
  late double distance;

  @override
  void initState() {
    super.initState();
    carrots = widget.game.carrots;
    distance = widget.game.distance;
    
    // Update values periodically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startUpdatingValues();
    });
  }

  void _startUpdatingValues() {
    // Create a timer to periodically update the display values
    // This ensures the HUD updates in real-time
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (mounted && !widget.game.isGameOver) {
        await Future.delayed(const Duration(milliseconds: 50)); // Update every 50ms
        if (mounted) {
          setState(() {
            carrots = widget.game.carrots;
            distance = widget.game.distance;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => widget.game.togglePause(),
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  widget.game.isPaused ? Icons.play_arrow : Icons.pause,
                  size: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 2.h,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Wrap(
                spacing: 4,
                children: List.generate(
                  widget.game.lives.clamp(0, 5),
                  (i) => Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            Container(
              width: 130.w,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                children: [
                  Text(
                    "${distance.toInt()} ft",
                    style: TextStyle(
                      color: Colors.brown[700],
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Distance",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 65.w,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.carrotearn.svg(),
                  SizedBox(width: 4.r),
                  CustomText(
                    text: "$carrots",
                    fontsize: 8.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor000000,
                  ),
                ],
              ),
            ),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
