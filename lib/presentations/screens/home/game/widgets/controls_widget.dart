import 'package:flutter/material.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class ControlsWidget extends StatelessWidget {
  final RabbitGame game;

  const ControlsWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              //onTap: () => game.rabbit.moveLeft(),
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
              // onTap: () => game.rabbit.moveRight(),
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
    );
  }
}
