import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rabbit_hole_app/core/constants/app_colors.dart';
import 'package:rabbit_hole_app/global/custom_assets/assets.gen.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_text.dart';

// ================== GAME SCREEN ==================
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = RabbitGame();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Game Area
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
                        child: CustomText(
                          text: rabbitGame.countdownValue.toString(),
                          fontsize: 60.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
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
                      // Top HUD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Pause Button
                          GestureDetector(
                            onTap: () => rabbitGame.togglePause(),
                            child: Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                rabbitGame.isPaused ? Icons.play_arrow : Icons.pause,
                                size: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          // Hearts
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Wrap(
                              spacing: 4,
                              children: List.generate(
                                rabbitGame.lives.clamp(0, 5),
                                    (i) => Icon(Icons.favorite, color: Colors.red, size: 18.sp),
                              ),
                            ),
                          ),

                          // Distance Counter
                          Container(
                            width: 130.w,
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: "${rabbitGame.distance.toInt()} ft",
                                  color: AppColors.bottomColorB17D28,
                                  fontsize: 18.sp,
                                ),
                                CustomText(
                                  text: "Distance",
                                  fontsize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor000000,
                                ),
                              ],
                            ),
                          ),

                          // Carrots Box
                          Container(
                            width: 65.w,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.r),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.icons.bigpacks.svg(),
                                SizedBox(width: 4.r),
                                CustomText(
                                  text: "${rabbitGame.carrots}",
                                  color: AppColors.textColor000000,
                                ),
                              ],
                            ),
                          ),

                          // Settings Button
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB3E5FC), Color(0xFF99DEFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Assets.icons.settings.svg(),
                          ),
                        ],
                      ),

                      // Invincible Status
                      if (rabbitGame.isInvincible && rabbitGame.lives > 0)
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          width: 130.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF12DA65).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "INVINCIBLE",
                              color: AppColors.textColor000000,
                              fontsize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    ],
                  );
                },
                'GameOver': (context, game) {
                  final rabbitGame = game as RabbitGame;
                  return Container(
                    color: Colors.black.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Game Over",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Distance: ${rabbitGame.distance.toInt()} ft",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            "Carrots: ${rabbitGame.carrots}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const GameScreen()),
                              );
                            },
                            child: const Text("Play Again"),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              initialActiveOverlays: const ['Countdown'],
            ),

            // Bottom Controls (Left & Right)
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
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_right,
                            size: 30,
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

// ================== GAME LOGIC ==================
class RabbitGame extends FlameGame with HasCollisionDetection {
  Color backgroundColor() =>AppColors.textColorFFFFFF;
  late Rabbit rabbit;
  int lives = 3;
  int carrots = 0;
  double distance = 0;
  double speed = 100;
  bool isInvincible = false;
  bool isGameStarted = false;
  bool isGameOver = false;
  bool isPaused = false;

  // Countdown related
  int countdownValue = 3;
  double countdownTimer = 0;

  Random random = Random();
  double invincibilityTimer = 0;
  static const double invincibilityDuration = 2.0;

  @override
  Future<void> onLoad() async {
    // Initialize rabbit
    rabbit = Rabbit()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..anchor = Anchor.center;
    add(rabbit);

    // Start countdown
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

    // Update invincibility
    if (isInvincible) {
      invincibilityTimer -= dt;
      if (invincibilityTimer <= 0) {
        isInvincible = false;
      }
    }

    // Increase speed over time
    speed += 10 * dt;

    // Update distance based on speed
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
        // Update countdown display
        overlays.remove('Countdown');
        overlays.add('Countdown');
      }
    }
  }

  void loseLife() {
    if (isInvincible) return;

    lives--;
    if (lives > 0) {
      // Make invincible temporarily
      isInvincible = true;
      invincibilityTimer = invincibilityDuration;
    } else {
      // Game over
      isGameOver = true;
      overlays.remove('HUD');
      overlays.add('GameOver');
      pauseEngine();
    }
  }

  void gainLife() {
    lives++;
    // Add some visual feedback here if needed
  }

  void collectCarrot() {
    carrots++;
    // Add some visual feedback here if needed
  }
}

class Rabbit extends RectangleComponent with HasGameRef<RabbitGame>, CollisionCallbacks {

  Rabbit() : super(
    size: Vector2(60, 60),
    paint: Paint()..color = Colors.brown,
  );

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    // Rabbit visual feedback for invincibility
    if (gameRef.isInvincible) {
      paint.color = paint.color == Colors.brown
          ? Colors.brown.withOpacity(0.5)
          : Colors.brown;
    } else {
      paint.color = Colors.brown;
    }
  }

  void moveLeft() {
    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    double newX = x - 100;
    if (newX >= 30) {
      x = newX;
    } else {
      x = 30;
    }
  }

  void moveRight() {
    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    double newX = x + 100;
    if (newX <= gameRef.size.x - 30) {
      x = newX;
    } else {
      x = gameRef.size.x - 30;
    }
  }
}

class GameObject extends RectangleComponent with CollisionCallbacks, HasGameRef<RabbitGame> {
  final String type;

  GameObject(this.type) : super(
    size: Vector2(40, 40),
    paint: Paint(),
  ) {
    // Set colors based on type
    switch (type) {
      case 'heart':
        paint.color = Colors.red;
        break;
      case 'carrot':
        paint.color = Colors.orange;
        break;
      case 'obstacle':
        paint.color = Colors.black;
        break;
      default:
        paint.color = Colors.grey;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    // Move upward (since rabbit is falling, objects appear to move up)
    y -= gameRef.speed * dt;

    // Remove when off screen
    if (y < -size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Rabbit) {
      switch (type) {
        case 'heart':
          gameRef.gainLife();
          break;
        case 'carrot':
          gameRef.collectCarrot();
          break;
        case 'obstacle':
          gameRef.loseLife();
          break;
      }
      removeFromParent();
    }
  }
}

class SpawnManager extends Component with HasGameRef<RabbitGame> {
  double timer = 0;
  double spawnInterval = 2.0;

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    timer += dt;

    // Decrease spawn interval as game progresses (increase difficulty)
    spawnInterval = (2.0 - (gameRef.distance / 1000)).clamp(0.5, 2.0);

    if (timer >= spawnInterval) {
      timer = 0;
      spawnRandomObject();
    }
  }

  void spawnRandomObject() {
    final rand = gameRef.random.nextDouble();
    String type;

    // 60% obstacles, 25% carrots, 15% hearts
    if (rand < 0.6) {
      type = 'obstacle';
    } else if (rand < 0.85) {
      type = 'carrot';
    } else {
      type = 'heart';
    }

    final positions = [
      gameRef.size.x * 0.2,
      gameRef.size.x * 0.5,
      gameRef.size.x * 0.8,
    ];

    final obj = GameObject(type)
      ..x = positions[gameRef.random.nextInt(positions.length)]
      ..y = gameRef.size.y + 50;

    gameRef.add(obj);
  }
}