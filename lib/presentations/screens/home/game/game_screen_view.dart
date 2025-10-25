import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/widgets/all_widgets.dart';

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
      body: Stack(
        children: [
          GameWidget(
            game: game,
            overlayBuilderMap: {
              'Countdown': (context, game) =>
                  CountdownWidget(game: game as RabbitGame),
              'HUD': (context, game) => HudWidget(game: game as RabbitGame),
              'GameOver': (context, game) => GameOverWidget(
                    game: game as RabbitGame,
                    onRestart: restartGame,
                  ),
            },
            initialActiveOverlays: const ['Countdown'],
          ),
          if (!game.isGameOver) ControlsWidget(game: game),
        ],
      ),
    );
  }
}