import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:rabbit_hole_app/core/helpers/haptic_helper.dart';
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
    String iconPath = 'icons/$type.svg';

    try {
      svg = await Svg.load(iconPath);
    } catch (e) {
      // Fallback if icon not found
      print('Could not load icon: $iconPath');
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
        HapticHelper.triggerLightFeedback();
      } else if (type == 'life') {
        gameRef.collectLife();
        HapticHelper.triggerLightFeedback();
      } else if (type == 'power') {
        gameRef.collectPower();
        HapticHelper.triggerSelectionFeedback();
      } else if (_isObstacle(type)) {
        gameRef.hitObstacle();
        HapticHelper.triggerHeavyFeedback();
      }
      removeFromParent();
    }
  }

  bool _isObstacle(String type) {
    return ['ball', 'chair', 'hat', 'trump_card', 'key'].contains(type);
  }
}
