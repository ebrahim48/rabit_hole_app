import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class RabbitGame extends FlameGame with HasCollisionDetection {
  late Rabbit rabbit;
  int lives = 3;
  int carrots = 0;
  double distance = 0;
  double speed = 200;
  Random random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    rabbit = Rabbit()
      ..position = Vector2(size.x / 2, size.y - 100)
      ..anchor = Anchor.center;
    add(rabbit);

    // add(SpawnManager(this));
  }

  void loseLife() {
    lives--;
    if (lives <= 0) {
      overlays.add('GameOver');
      pauseEngine();
    }
  }

  void gainLife() {
    lives++;
  }

  void collectCarrot() {
    carrots++;
  }
}

class Rabbit extends SpriteComponent with HasGameRef<RabbitGame>, CollisionCallbacks {
  Rabbit() : super(size: Vector2(60, 60));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('rabbit.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameRef.distance += 100 * dt;
  }

  void moveLeft() {
    x = x - 80 < 30 ? 30 : x - 80;
  }

  void moveRight() {
    x = x + 80 > gameRef.size.x - 30 ? gameRef.size.x - 30 : x + 80;
  }
}

class Obstacle extends SpriteComponent with CollisionCallbacks, HasGameRef<RabbitGame> {
  final String type;
  Obstacle(this.type) : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('$type.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += gameRef.speed * dt;
    if (y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Rabbit) {
      if (type == 'heart') {
        gameRef.gainLife();
      } else if (type == 'carrot') {
        gameRef.collectCarrot();
      } else {
        gameRef.loseLife();
      }
      removeFromParent();
    }
  }
}

class SpawnManager extends Component with HasGameRef<RabbitGame> {
  double timer = 0;

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer > 1.5) {
      timer = 0;
      final type = gameRef.random.nextBool() ? 'heart' : 'carrot';
      final obs = Obstacle(type)
        ..x = [50.0, gameRef.size.x / 2, gameRef.size.x - 50.0][gameRef.random.nextInt(3)]
        ..y = -50;
      gameRef.add(obs);
    }
  }
}
