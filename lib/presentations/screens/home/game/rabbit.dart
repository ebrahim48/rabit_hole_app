import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/game_object.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class Rabbit extends PositionComponent
    with HasGameRef<RabbitGame>, CollisionCallbacks {
  Rabbit() : super(size: Vector2(60, 60));

  late SvgComponent rabbitSprite;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = await Svg.load('icons/blue_rabbit.svg');
    rabbitSprite = SvgComponent(svg: sprite, size: Vector2(60, 60));
    // Initially facing left (default), so flip horizontally
    rabbitSprite.flipHorizontally();
    add(rabbitSprite);
    add(RectangleHitbox());
  }

  void move(double dx) {
    if (!gameRef.isGameStarted || gameRef.isPaused) return;
    x = (x + dx).clamp(30, gameRef.size.x - 30);

    // Flip rabbit based on drag direction
    if (dx > 0) {
      // Moving right - face right
      if (!rabbitSprite.isFlippedHorizontally) {
        rabbitSprite.flipHorizontally();
      }
    } else if (dx < 0) {
      // Moving left - face left
      if (rabbitSprite.isFlippedHorizontally) {
        rabbitSprite.flipHorizontally();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is GameObject && other.type == 'obstacle') {
      gameRef.gameOver();
    }
  }
}
