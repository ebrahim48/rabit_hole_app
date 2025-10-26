import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/spawn_manager.dart';

class RabbitGame extends FlameGame with HasCollisionDetection, DragCallbacks {
  @override
  Color backgroundColor() => AppColors.textColorBC844A;
  final VoidCallback onGameOver;

  RabbitGame({required this.onGameOver});

  late Rabbit rabbit;
  int lives = 3;
  int carrots = 0;
  double distance = 0;
  double bestDistance = 0;
  double speed = 100;
  bool isGameStarted = false;
  bool isGameOver = false;
  bool isPaused = false;
  int countdownValue = 3;
  double countdownTimer = 0;
  Random random = Random();

  @override
  Future<void> onLoad() async {
    rabbit =
        Rabbit()
          ..position = Vector2(size.x / 2, size.y - 64)
          ..anchor = Anchor.center;
    add(rabbit);
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = 0;
    countdownValue = 3;
  }

  void startGame() {
    isGameStarted = true;
    overlays.remove('Countdown');
    overlays.add('HUD');
    add(SpawnManager());
  }

  void togglePause() {
    if (isPaused) {
      resumeEngine();
      isPaused = false;
    } else {
      pauseEngine();
      isPaused = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isGameStarted) {
      updateCountdown(dt);
      return;
    }
    if (isPaused) return;

    speed += 10 * dt;
    distance += speed * dt * 0.1;
  }

  void updateCountdown(double dt) {
    countdownTimer += dt;
    if (countdownTimer >= 1.0) {
      countdownValue--;
      countdownTimer = 0;
      if (countdownValue <= 0) {
        startGame();
      } else {
        overlays.remove('Countdown');
        overlays.add('Countdown');
      }
    }
  }

  void gameOver() {
    if (isGameOver) return;
    isGameOver = true;
    bestDistance = distance > bestDistance ? distance : bestDistance;
    overlays.remove('HUD');
    overlays.add('GameOver');
    pauseEngine();
    onGameOver();
  }

  void collectCarrot() {
    carrots++;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!isGameStarted || isGameOver || isPaused) return;
    rabbit.move(event.localDelta.x);
  }
}
