
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
    String type = rand < 0.6 ? 'obstacle' : 'carrot';
    final positions = [
      gameRef.size.x * 0.2,
      gameRef.size.x * 0.5,
      gameRef.size.x * 0.8,
    ];
    final obj =
        GameObject(type)
          ..x = positions[gameRef.random.nextInt(positions.length)]
          ..y = gameRef.size.y + 50;
    gameRef.add(obj);
  }
}
