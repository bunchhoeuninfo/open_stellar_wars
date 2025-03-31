import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/plasma_fighter.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/swarm_fighter.dart';

class NormalBullet extends PositionComponent with CollisionCallbacks {

  final double speed;
  final int damage;   // Define how much damage the bullet does
  SpriteComponent bulletSprite;

  NormalBullet({required this.speed, required this.damage ,required Vector2 position, required Sprite sprite})
      : bulletSprite = SpriteComponent(sprite: sprite, size: Vector2(10, 20)), // Adjust bullet size
      super(position: position, size: Vector2(10, 45));


  @override
  Future<void> onLoad() async {    
    try {
      super.onLoad();
      LogUtil.debug('Try to initialize Normal Bullet sprite...');
      add(RectangleHitbox()); // Add a collision shape to detect collisions
      add(bulletSprite); // Attach the sprite component to the bullet
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

   @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlasmaFighter) {
      other.takeHit(damage);
      // Deal damage to the enemy
      // Remove the bullet when it collides with an enemy
      removeFromParent();
    }

    if (other is SwarmFighter) {
      other.takeHit(damage);
      // Deal damage to the enemy
      // Remove the bullet when it collides with an enemy
      removeFromParent();
    }
    
  } 

  @override
  void update (double dt) {
    super.update(dt);
    position.y -= speed * dt;

    // Remove the bullet when it moves off the screen
    if (position.y < -size.y) {
      removeFromParent();
    }
  }


}