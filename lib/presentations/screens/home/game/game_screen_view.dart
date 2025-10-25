
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/global/custom_assets/assets.gen.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RabbitGame game;

  @override
  void initState() {
    super.initState();
    game = RabbitGame(
      onGameOver: () {
        setState(() {});
      },
    );
  }

  void restartGame() {
    setState(() {
      game = RabbitGame(
        onGameOver: () {
          setState(() {});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GameWidget(
              game: game,
              overlayBuilderMap: {
                'Countdown': (context, game) {
                  final rabbitGame = game as RabbitGame;
                  return Center(
                    child: Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 3),
                      ),
                      child: Center(
                        child: Text(
                          rabbitGame.countdownValue.toString(),
                          style: TextStyle(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                'HUD': (context, game) {
                  final rabbitGame = game as RabbitGame;
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => rabbitGame.togglePause(),
                            child: Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFB3E5FC),
                                    Color(0xFF99DEFE),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                rabbitGame.isPaused
                                    ? Icons.play_arrow
                                    : Icons.pause,
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
                                rabbitGame.lives.clamp(0, 5),
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
                                  "${rabbitGame.distance.toInt()} ft",
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
                                  text: "${rabbitGame.carrots}",
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
                },
                'GameOver': (context, game) {
                  final rabbitGame = game as RabbitGame;
                  return Center(
                    child: Container(
                      width: 375.w,
                      height: 690.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.ganeheart.svg(
                              height: 64.h,
                              width: 64.w,
                            ),
                            SizedBox(height: 16.h),
                            CustomText(
                              text: "Game Over!",
                              color: AppColors.textColor000000,
                              fontsize: 23.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 8.h),
                            CustomText(
                              text: "The rabbit hit an obstacle",
                              color: AppColors.textColor333333,
                              fontsize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              width: 346.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white.withOpacity(0.85),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Distance',
                                    color: AppColors.textColor333333,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  CustomText(
                                    text: "${rabbitGame.distance.toInt()} ft",
                                    color: AppColors.textColor000000,
                                    fontsize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "Best: ${rabbitGame.bestDistance} ft",
                                    color: AppColors.textColor333333,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              width: 346.w,
                              height: 75.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(width: 18.w),
                                        Assets.icons.carrotearn.svg(
                                          height: 24.h,
                                          width: 24.w,
                                        ),
                                        SizedBox(width: 18.w),
                                        CustomText(
                                          text: "Carrots Earned:",
                                          color: AppColors.textColor000000,
                                          fontsize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const Spacer(),
                                        CustomText(
                                          text: "+${rabbitGame.carrots * 5}",
                                          color: AppColors.textColor000000,
                                          fontsize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(width: 18.w),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    CustomText(
                                      text:
                                          "Special Note: Exchange 20 Super-carrots for 1 Original Carrot.",
                                      color: AppColors.textColor000000,
                                      fontsize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD93B),
                                minimumSize: Size(346.w, 52.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                rabbitGame.overlays.remove('GameOver');
                                restartGame();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Assets.icons.play.svg(
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 12.w),
                                  CustomText(
                                    text: "Play Again",
                                    color: AppColors.textColor000000,
                                    fontsize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 12.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF87914),
                                minimumSize: Size(346.w, 42.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Assets.icons.watch.svg(
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 12.w),
                                  CustomText(
                                    text: "Watch Ad for +20 Carrots",
                                    color: AppColors.textColorFFFFFF,
                                    fontsize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.bgColor,
                                    minimumSize: Size(170.w, 42.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.icons.leaderboard.svg(),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        text: "Leaderboard",
                                        fontsize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor000000,
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.bgColor,
                                    minimumSize: Size(170.w, 42.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.icons.home.svg(),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        text: "Home",
                                        fontsize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor000000,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD93B),
                                minimumSize: Size(345.w, 42.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Assets.icons.share.svg(
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 12.w),
                                  CustomText(
                                    text: "Share & Get Free Skin!",
                                    color: AppColors.textColor000000,
                                    fontsize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            CustomText(
                              text:
                                  '“Being at the beginning, and go on till you come the end: then stop.”',
                              fontsize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor8A8A8A,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              },
              initialActiveOverlays: const ['Countdown'],
            ),

            if (!game.isGameOver)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => game.rabbit.moveLeft(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlue],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_left,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => game.rabbit.moveRight(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlue],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_right,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
