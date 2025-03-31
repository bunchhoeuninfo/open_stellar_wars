import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_shooting.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/enemy_bullets/enemy_normal_bullet.dart';
import 'package:open_stellar_wars/game_widgets/components/enemy_bullets/enemy_special_bullet.dart';
import 'package:open_stellar_wars/game_widgets/components/enemy_bullets/plasma_fighters/plasma_fighter_normal_bullet.dart';
import 'package:open_stellar_wars/game_widgets/components/enemy_bullets/plasma_fighters/plasma_fighter_special_bullet.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class PlasmaFighterShootingImpl implements IPlasmaFighterShooting {

  final StellarWarGame gameRef;
  double _lastShotTime = 0;
  final double _fireRate;
  final double _bulletSpeed;

   PlasmaFighterShootingImpl({
    required this.gameRef,
    required double fireRate,
    required double bulletSpeed,
  })  : _fireRate = fireRate,
        _bulletSpeed = bulletSpeed;

  @override
  Future<void> fireNormalBullet(Vector2 position, Vector2 size) async {
    if (_lastShotTime >= _fireRate) {
      _lastShotTime = 0; // Reset the timer

      final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

      final bullet = EnemyNormalBullet(
        speed: _bulletSpeed, 
        damage: 1,
        position: Vector2(position.x + size.x / 2 - 5, position.y), 
        sprite: bulletSprite,
      );

      gameRef.add(bullet);
    }
  }

  @override
  Future<void> fireSpecialBullet(Vector2 position, Vector2 size) async {
    if (_lastShotTime >= _fireRate) {
      _lastShotTime = 0; // Reset the timer

      final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

      final bullet = EnemySpecialBullet(
        speed: _bulletSpeed, 
        damage: 2,
        position: Vector2(position.x + size.x / 2 - 5, position.y), 
        sprite: bulletSprite,
      );

      gameRef.add(bullet);
    }
  }

  @override
  void shoot() {
    // TODO: implement shoot
  }

  @override
  void shootTripleShotBullet() {
    // TODO: implement shootTripleShotBullet
  }

  @override
  void update(double dt) {
    _lastShotTime += dt;
  }
  
  @override
  Future<void> firePlasmaNormalBullet(Vector2 position, Vector2 size) async {
    try {
      LogUtil.debug('Try to fire plasma normal bullet, _lastShotTime=$_lastShotTime, _fireRate=$_fireRate');
      if (_lastShotTime >= _fireRate) {
        _lastShotTime = 0; // Reset the timer

        final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

        final bullet = PlasmaFighterNormalBullet(
          speed: _bulletSpeed, 
          damage: 2,
          position: Vector2(position.x + size.x / 2 - 5, position.y), 
          sprite: bulletSprite,
        );

        gameRef.add(bullet);
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    } 
  }
  
  @override
  Future<void> firePlasmaSpecialBullet(Vector2 position, Vector2 size) async {
    try {
      LogUtil.debug('Try to fire plasma special bullet, _lastShotTime=$_lastShotTime, _fireRate=$_fireRate');
      if (_lastShotTime >= _fireRate) {
        _lastShotTime = 0; // Reset the timer

        final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

        final bullet = PlasmaFighterSpecialBullet(
          speed: _bulletSpeed, 
          damage: 2,
          position: Vector2(position.x + size.x / 2 - 5, position.y), 
          sprite: bulletSprite,
        );

        gameRef.add(bullet);
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }  
  }
}