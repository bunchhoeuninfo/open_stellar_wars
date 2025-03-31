import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/players/player_shooting.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/player_bullets/normal_bullet.dart';
import 'package:open_stellar_wars/game_widgets/components/player_bullets/special_bullet.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class PlayerShootingImpl implements IPlayerShooting {

  final StellarWarGame gameRef;
  double _lastShotTime = 0;
  final double _fireRate;
  final double _bulletSpeed;

   PlayerShootingImpl({
    required this.gameRef,
    required double fireRate,
    required double bulletSpeed,
  })  : _fireRate = fireRate,
        _bulletSpeed = bulletSpeed;



  @override
  void shootStraightShotBullet() {
    // TODO: implement shootStraightShotBullet
  }

  @override
  void shootTripleShotBullet() {
    // TODO: implement shootTripleShotBullet
  }

  @override
  Future<void> fireNormalBullet(Vector2 position, Vector2 size) async {
    try {
      if (_lastShotTime >= _fireRate) {
        _lastShotTime = 0; // Reset the timer

        final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

        final bullet = NormalBullet(
          speed: _bulletSpeed, 
          damage: 1,
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
  void update(double dt) {
    _lastShotTime += dt;
  }
  
  @override
  Future<void> fireSpecialBullet(Vector2 position, Vector2 size) async {
    try {
      if (_lastShotTime >= _fireRate) {
        _lastShotTime = 0; // Reset the timer

        final bulletSprite = await gameRef.loadSprite('players/bullets/normal_bullet.png');

        final bullet = SpecialBullet(
          speed: _bulletSpeed, 
          damage: 2,
          position: Vector2(position.x + size.x / 2 - 5, position.y), 
          sprite: bulletSprite,
        );

        gameRef.add(bullet);
      }
    } catch (e) {
      LogUtil.error('Exception $e');
    }    
  }

}