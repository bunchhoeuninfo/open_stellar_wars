

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_figher_animation.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_animation_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_shooting.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_shooting_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_state.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_state_impl.dart';
import 'package:open_stellar_wars/core/state/swarm_fighter_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class SwarmFighter extends SpriteAnimationComponent with HasGameRef<StellarWarGame>, CollisionCallbacks {
  int hitPoints = 2;    // Default hit points
  late Timer shootingTimer;
  late ISwarmFighterShooting _swarmFighterShooting;
  final _swarmFighterSize = Vector2(45, 55);
  final ISwarmFighter _swarmFighter = SwarmFighterImpl();
  final ISwarmFighterState _swarmFighterState = SwarmFighterStateImpl(); 
  final ISwarmFighterAnimation _swarmFighterAnimation = SwarmFighterAnimationImpl();


  SwarmFighter(Vector2 position, int? customHitPoints)
      : super(position: position, size: Vector2(45, 55)) {
        if (customHitPoints != null) {
          hitPoints = customHitPoints;    // Set custom hit points if provided
        }
        shootingTimer = Timer(1.5, onTick: () => _shoot(false), repeat: true);  // Shoot every 1.5 seconds
      }

  
  @override
  Future<void> onLoad() async {    
    try {
      super.onLoad();
      LogUtil.debug('Try to initialize Swarm Fighter sprite...');
      _swarmFighterState.stateNotifier.value = SwarmFighterState.idle;
      _swarmFighter.setSwarmFighterSpawnBounds();
      animation = _swarmFighter.applySwarmFighterAnimation(gameRef, _swarmFighterSize);

      _swarmFighterShooting = SwarmFighterShootingImpl(
        gameRef: gameRef, 
        fireRate: 0.3, 
        bulletSpeed: 200);
      shootingTimer.start();  // Start auto-shooting
      add(TimerComponent(period: 1.5, repeat: true, onTick: () => _shoot(false)));
      add(RectangleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  void _shoot(bool isSpecial) {
    if (isSpecial) {
      _swarmFighterShooting.fireSwarmSpecialBullet(position, size);
    } else {
      _swarmFighterShooting.fireSwarmNormalBullet(position, size);
    }    
  }

  @override
  void update(double dt) {
    super.update(dt);
    _swarmFighter.applyGravity(dt, gameRef, this);
    shootingTimer.update(dt);
    _swarmFighterShooting.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

  void _explode() {
    // Add explosion animation or effects here
    final explosion = SpriteAnimationComponent(
      //animation: explodingAnimation(gameRef, Vector2(64, 64)), // Explosion animation
      animation: _swarmFighterAnimation.explodingAnimation(gameRef, Vector2(65, 85)),
      position: position,
      size: Vector2(65, 85),
      removeOnFinish: true,  // Remove explosion after animation completes
    ); 
    gameRef.add(explosion);    
    removeFromParent();
  }

  void takeHit(int damage) {
    hitPoints -= damage;
    if (hitPoints <= 0) {
      _explode();
    }
  }
}