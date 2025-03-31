import 'package:flame/components.dart';

abstract class ISwarmFighterShooting {
  Future<void> fireNormalBullet(Vector2 position, Vector2 size);
  Future<void> fireSpecialBullet(Vector2 position, Vector2 size);
  Future<void> fireSwarmSpecialBullet(Vector2 position, Vector2 size);
  Future<void> fireSwarmNormalBullet(Vector2 position, Vector2 size);
  void update(double dt);

}