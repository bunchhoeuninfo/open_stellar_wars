import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_animation.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_animation_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_shooting.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_shooting_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_state.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_state_impl.dart';
import 'package:open_stellar_wars/core/state/plasma_fighter_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class PlasmaFighter extends SpriteAnimationComponent with HasGameRef<StellarWarGame>, CollisionCallbacks {
  int hitPoints = 2;    // Default hit 
  late Timer shootingTimer;
  late IPlasmaFighterShooting _plasmaFighterShooting;

  PlasmaFighter( Vector2 position, int? customHitPoints) 
    : super(position: position, size: Vector2(45, 55), ) {
      if (customHitPoints != null) {
        hitPoints = customHitPoints;    // Set custom hit points if provided
      }
      shootingTimer = Timer(1.5, onTick: () => _shoot(false), repeat: true);   // Shoot every 1.5 seconds
    }

  final _plasmaFrigateSize = Vector2(45, 55);
  final IPlasmaFighter _plasmaFighter = PlasmaFighterImpl();
  final IPlasmaFighterState _plasmaFighterState = PlasmaFighterStateImpl();
  final IPlasmaFighterAnimation _plasmaFighterAnimation = PlasmaFighterAnimationImpl();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to initialize Plasma Frigate sprite...');
      _plasmaFighterState.stateNotifier.value = PlasmaFighterState.idle;
      _plasmaFighter.setPlasmaFighterSpawnBounds();
      animation = _plasmaFighter.applyPlasmaFighterAnimation(gameRef, _plasmaFrigateSize);
      
      _plasmaFighterShooting = PlasmaFighterShootingImpl(
        gameRef: gameRef, 
        fireRate: 0.3, 
        bulletSpeed: 200);
      shootingTimer.start();  // Start auto-shooting
      add(TimerComponent(period: 1.5, repeat: true, onTick: () => _shoot(false)));
      add(CircleHitbox());      
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _plasmaFighter.applyGravity(dt, gameRef, this);
    shootingTimer.update(dt);
    _plasmaFighterShooting.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

  void _explode() {
    // Add explosion animation or effects here
    final explosion = SpriteAnimationComponent(
      animation: _plasmaFighterAnimation.explodingAnimation(gameRef, Vector2(65, 85)),
      position: position,
      size: Vector2(65, 85),
      removeOnFinish: true,   // Remove explosion after animation completes
    );
    gameRef.add(explosion);
    removeFromParent();
  }

  void _shoot(bool isSpecial) {
    if (isSpecial) {
      _plasmaFighterShooting.firePlasmaSpecialBullet(position, size);
    } else {
      _plasmaFighterShooting.firePlasmaNormalBullet(position, size);
    }
  }

  void takeHit(int damage) {
    hitPoints -= damage;
    if (hitPoints <= 0) {
      _explode();
    }
  }

}