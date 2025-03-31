import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage.dart';
import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage_impl.dart';
import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage_state.dart';
import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage_state_impl.dart';
import 'package:open_stellar_wars/core/state/health_repair_damage_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class HealthRepairDamages extends SpriteAnimationComponent with CollisionCallbacks {

  HealthRepairDamages(Vector2 position) :
    super(position: position, size: Vector2(35, 35));

  final double _fallSpeed = 200;
  double _velocityY = 0;
  bool _isGrounded = false;
  double _goldCoinTimer = 0;
  final double _goldCoionSpawnInterval = 2.0;  
  final IHealthRepairDamage _healthRepairDamage = HealthRepairDamageImpl();
  final IHealthRepairDamageState _healthRepairDamageState = HealthRepairDamageStateImpl();

  @override
  Future<void> onLoad() async {
    try {
      super.onLoad();
      LogUtil.debug('To to initialize health repair damanage object');
      _healthRepairDamageState.stateNotifier.value = HealthRepairDamageState.idle;
      
      add(RectangleHitbox());      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    LogUtil.debug('Object collide');
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

    position.y += _fallSpeed * dt;
    
    //LogUtil.debug('Swarm fighter, position.y: ${position.y}, size.y: ${size.y}');

    // Remove the bullet when it moves off the bottom screen
    if (position.y < -size.y) {
      removeFromParent();
    }
  }

}