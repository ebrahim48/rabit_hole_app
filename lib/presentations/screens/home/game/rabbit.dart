
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

import 'package:flutter/material.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/game_object.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class Rabbit extends PositionComponent
    with HasGameRef<RabbitGame>, CollisionCallbacks {
  Rabbit() : super(size: Vector2(60, 60));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = await Svg.load('icons/rabit.svg');
    add(
      SvgComponent(
        svg: sprite,
        size: Vector2(60, 60),
      ),
    );
    add(RectangleHitbox());
  }

  void moveLeft() {
    if (!gameRef.isGameStarted || gameRef.isPaused) return;
    x = (x - 100).clamp(30, gameRef.size.x - 30);
  }

  void moveRight() {
    if (!gameRef.isGameStarted || gameRef.isPaused) return;
    x = (x + 100).clamp(30, gameRef.size.x - 30);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is GameObject && other.type == 'obstacle') {
      gameRef.gameOver();
    }
  }
}
