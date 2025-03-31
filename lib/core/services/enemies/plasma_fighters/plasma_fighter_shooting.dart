import 'package:flame/components.dart';

abstract class IPlasmaFighterShooting {
  void shoot();
  void shootTripleShotBullet();
  Future<void> fireNormalBullet(Vector2 position, Vector2 size);
  Future<void> fireSpecialBullet(Vector2 position, Vector2 size);
  Future<void> firePlasmaNormalBullet(Vector2 position, Vector2 size);
  Future<void> firePlasmaSpecialBullet(Vector2 position, Vector2 size);
  void update(double dt);

}