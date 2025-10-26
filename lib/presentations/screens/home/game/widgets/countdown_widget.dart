import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class CountdownWidget extends StatelessWidget {
  final RabbitGame game;

  const CountdownWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Don't show countdown if game is over or game has started
    if (game.isGameOver || game.isGameStarted) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 3),
        ),
        child: Center(
          child: Text(
            game.countdownValue.toString(),
            style: TextStyle(
              fontSize: 60.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
