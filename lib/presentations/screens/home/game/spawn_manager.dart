
import 'package:flame/components.dart';

import 'package:rabbit_hole_app/presentations/screens/home/game/game_object.dart';
import 'package:rabbit_hole_app/presentations/screens/home/game/rabbit_game.dart';

class SpawnManager extends Component with HasGameRef<RabbitGame> {
  double timer = 0;
  double spawnInterval = 2.0;

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameStarted || gameRef.isPaused) return;

    timer += dt;
    spawnInterval = (2.0 - (gameRef.distance / 1000)).clamp(0.5, 2.0);

    if (timer >= spawnInterval) {
      timer = 0;
      spawnRandomObject();
    }
  }

  void spawnRandomObject() {
    final rand = gameRef.random.nextDouble();
    String type;

    // Distribution: 40% carrot, 35% obstacles, 15% life, 10% power
    if (rand < 0.40) {
      type = 'carrot';
    } else if (rand < 0.75) {
      // Obstacles: ball, chair, hat, trump_card, key
      final obstacles = ['ball', 'chair', 'hat', 'trump_card', 'key'];
      type = obstacles[gameRef.random.nextInt(obstacles.length)];
    } else if (rand < 0.90) {
      type = 'life';
    } else {
      type = 'power';
    }

    final positions = [
      gameRef.size.x * 0.2,
      gameRef.size.x * 0.5,
      gameRef.size.x * 0.8,
    ];
    final obj =
        GameObject(type)
          ..x = positions[gameRef.random.nextInt(positions.length)]
          ..y = -50;
    gameRef.add(obj);
  }
}
