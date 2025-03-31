import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class SwarmFighterSpecialBullet extends PositionComponent with CollisionCallbacks {
  final double speed;
  final int damage;
  SpriteComponent bulletSprite;  // Sprite is now a component

  SwarmFighterSpecialBullet({required this.speed, required this.damage, required Vector2 position, required Sprite sprite})
      : bulletSprite = SpriteComponent(sprite: sprite, size: Vector2(10, 20)), // Adjust bullet size
        super(position: position, size: Vector2(10, 20)); // Define bullet size
        

  @override
  Future<void> onLoad() async {    
    try {
      super.onLoad();
      LogUtil.debug('Trying to initialize swarm fighter special bullet...');
      add(RectangleHitbox()); // Add a collision shape to detect collisions
      add(bulletSprite); // Attach the sprite component to the bullet
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // To implement the player explode later 
    /*if (other is Player) {
      other.takeHit(damage);
      // Deal damage to the player
      // Remove the bullet when it collides with the player
      removeFromParent();
    }*/
  }

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