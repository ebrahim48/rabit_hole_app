import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/core/helpers/audio_service.dart';
import 'package:rabbit_hole_app/core/helpers/haptic_helper.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/spawn_manager.dart';

class RabbitGame extends FlameGame with HasCollisionDetection, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0x00000000); // Transparent background
  final VoidCallback onGameOver;

  RabbitGame({required this.onGameOver});

  late Rabbit rabbit;
  int lives = 1;
  int maxLives = 3;
  int carrots = 0;
  double distance = 0;
  double bestDistance = 0;
  double speed = 100;
  double baseSpeed = 100;
  bool isGameStarted = false;
  bool isGameOver = false;
  bool isPaused = false;
  int countdownValue = 3;
  double countdownTimer = 0;
  Random random = Random();

  late AudioService audioService;

  @override
  Future<void> onLoad() async {
    // Get existing AudioService or create new one
    if (!Get.isRegistered<AudioService>()) {
      Get.put(AudioService());
    }
    audioService = Get.find<AudioService>();
    
    rabbit =
        Rabbit()
          ..position = Vector2(size.x / 2, size.y - 64)
          ..anchor = Anchor.center;
    add(rabbit);

    // Start background music
    audioService.playMusic();

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
    if (isGameOver) return;
    if (!isGameStarted) {
      updateCountdown(dt);
      return;
    }
    if (isPaused) return;

    baseSpeed += 10 * dt;
    speed = baseSpeed;
    distance += speed * dt * 0.1;
  }

  void updateCountdown(double dt) {
    if (isGameOver) return;
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
    overlays.clear();
    overlays.add('GameOver');
    pauseEngine();
    audioService.stopMusic();
    HapticHelper.triggerErrorFeedback();
    onGameOver();
  }

  void collectCarrot() {
    carrots++;
    audioService.playCollectSound();
  }

  void collectLife() {
    if (lives < maxLives) {
      lives++;
      audioService.playCollectSound();
    }
  }

  void collectPower() {
    // Increase speed by 50%
    baseSpeed *= 1.5;
    speed = baseSpeed;
    audioService.playPowerUpSound();
  }

  void hitObstacle() {
    lives--;
    audioService.playHitSound();
    if (lives <= 0) {
      gameOver();
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!isGameStarted || isGameOver || isPaused) return;
    rabbit.move(event.localDelta.x);
  }
}
