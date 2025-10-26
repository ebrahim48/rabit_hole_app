import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class GameObject extends PositionComponent
    with CollisionCallbacks, HasGameRef<RabbitGame> {
  final String type;

  GameObject(this.type) : super(size: Vector2(40, 40));

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Svg? svg;
    if (type == 'carrot') {
      svg = await Svg.load('icons/carrot.svg');
    } else if (type == 'obstacle') {
      final obstacleIcons = [
        'icons/ball.svg',
        'icons/chair.svg',
        'icons/power.svg',
      ];
      final randomIconPath =
          obstacleIcons[Random().nextInt(obstacleIcons.length)];
      svg = await Svg.load(randomIconPath);
    }

    if (svg != null) {
      final svgComponent = SvgComponent(svg: svg, size: size);
      add(svgComponent);
    }

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameStarted || gameRef.isPaused) return;
    y += gameRef.speed * dt;
    if (y > gameRef.size.y) removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
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
