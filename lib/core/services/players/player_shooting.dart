import 'package:flame/components.dart';

abstract class IPlayerShooting {
  Future<void> fireNormalBullet(Vector2 position, Vector2 size);
  Future<void> fireSpecialBullet(Vector2 position, Vector2 size);
  void update(double dt);
  void shootStraightShotBullet();
  void shootTripleShotBullet();
}