import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/core/helpers/audio_service.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/widgets/all_widgets.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/widgets/road_separator_painter.dart';

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
    
    // Initialize AudioService if not already done
    if (!Get.isRegistered<AudioService>()) {
      Get.put(AudioService());
    }
    
    game = RabbitGame(
      onGameOver: () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // Stop music when leaving game screen
    Get.find<AudioService>().stopMusic();
    super.dispose();
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBC844A), // Top color: #BC844A
              Color(0xFF502A0E), // Bottom color: #502A0E
            ],
          ),
        ),
        child: Stack(
          children: [
            // Road separators - bottom layer
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: RoadSeparatorPainter(
                    dashHeight: 4.0,
                    dashGap: 4.0,
                    strokeWidth: 0.5,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            GameWidget(
              game: game,
              overlayBuilderMap: {
                'Countdown':
                    (context, game) =>
                        CountdownWidget(game: game as RabbitGame),
                'HUD': (context, game) => HudWidget(game: game as RabbitGame),
                'GameOver':
                    (context, game) => GameOverWidget(
                      game: game as RabbitGame,
                      onRestart: restartGame,
                    ),
              },
              initialActiveOverlays: const ['Countdown'],
            ),
          ],
        ),
      ),
    );
  }
}
