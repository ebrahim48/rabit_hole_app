
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class GameObject extends RectangleComponent
    with CollisionCallbacks, HasGameRef<RabbitGame> {
  final String type;

  GameObject(this.type) : super(size: Vector2(40, 40), paint: Paint());

  @override
  Future<void> onLoad() async {
    super.onLoad();
    switch (type) {
      case 'carrot':
        paint.color = Colors.orange;
        break;
      case 'obstacle':
        paint.color = Colors.black;
        break;
      default:
        paint.color = Colors.grey;
    }
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameStarted || gameRef.isPaused) return;
    y -= gameRef.speed * dt;
    if (y < -size.y) removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Rabbit) {
      if (type == 'carrot') {
        gameRef.collectCarrot();
      } else if (type == 'obstacle') {
        gameRef.gameOver();
      }
      removeFromParent();
    }
  }
}
