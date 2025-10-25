import 'package:get/get.dart';
import '../presentations/screens/home/game_screen.dart';

class GameController extends GetxController {
  late RabbitGame game;

  @override
  void onInit() {
    super.onInit();
    game = RabbitGame(onGameOver: onGameOver);
  }

  void restartGame() {
    game = RabbitGame(onGameOver: onGameOver);
    update();
  }

  void onGameOver() {
    update();
  }
}
