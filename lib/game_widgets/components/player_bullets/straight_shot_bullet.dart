import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class StraightShotBullet extends SpriteComponent with HasGameRef<StellarWarGame>  {
  final double speed;

  StraightShotBullet({required this.speed, required Vector2 position, required Sprite sprite})
      : super(sprite: sprite, position: position, size: Vector2(10, 20));

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= speed * dt;

    // Remove the bullet when it moves off the screen
    if (position.y < -size.y) {
      removeFromParent();
    }
  }

}