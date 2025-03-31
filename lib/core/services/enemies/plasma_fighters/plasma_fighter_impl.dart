import 'dart:math';

import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_animation.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_state.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_animation_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_state_impl.dart';
import 'package:open_stellar_wars/core/state/plasma_fighter_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/core/utils/screen_utils.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/plasma_fighter.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class PlasmaFighterImpl implements IPlasmaFighter {

  // Plasma fighter
  final double _plasmaSpawnInterval = 4.2; // plasma fighter spawn interval every 7.2 seconds
  double _plasmaTimer = 0;

  final double _spawnSpeed = 80;   // Speed of the plasma fighter movement

  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final Random _random = Random();
  final IPlasmaFighterState _plasmaFighterState = PlasmaFighterStateImpl();
  final IPlasmaFighterAnimation _plasmaFighterAnimation = PlasmaFighterAnimationImpl();

  @override
  void applyGravity(double dt, StellarWarGame gameRef, PlasmaFighter plasmaFighter) {
    try {
      LogUtil.debug('Try to apply gravity to Plasma Frigate sprite...');
      plasmaFighter.position.y += _spawnSpeed * dt;
      _plasmaFighterState.stateNotifier.value = PlasmaFighterState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y - plasmaFighter.size.y;
      if (plasmaFighter.position.y > groundLevel) {        
        _plasmaFighterState.stateNotifier.value = PlasmaFighterState.hitGround;
        plasmaFighter.removeFromParent();
      }

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void setPlasmaFighterSpawnBounds() {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;
      _maxY = screenSize.y;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void spawnPlasmaFighterEnemies(StellarWarGame gameRef, double dt) {
    _plasmaTimer += dt;
    try {
      //LogUtil.debug('Try to initialize Plasma Frigate sprite...');
      if (_plasmaTimer >= _plasmaSpawnInterval ) {
        _plasmaTimer = 0;
        Vector2 screenSize = ScreenUtils.getScreenSize();
        _minX = 0;
        _maxX = screenSize.x;
        _minY = 0;
        _maxY = screenSize.y;

        // Define number o columns an selecte one at random
        int totalColumns = 5; // Assuming 5 columns layout
        int selectedColumn = _random.nextInt(totalColumns);   // Pick a column randomly

        // Calculate the X position of the selected column
        double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
        double columnX = _minX + (selectedColumn * columnSpacing);

        PlasmaFighter plasmaFrigateEnemies = PlasmaFighter(Vector2 (columnX, _minY), null);
        gameRef.add(plasmaFrigateEnemies);
      }      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  SpriteAnimation applyPlasmaFighterAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    PlasmaFighterState plasmaFighterState = _plasmaFighterState.stateNotifier.value;
    try {
      LogUtil.debug('Try to apply Plasma Frigate animation...');
      switch (plasmaFighterState) {
        case PlasmaFighterState.idle:
          return _plasmaFighterAnimation.idleAnimation(gameRef, spriteSize);
        case PlasmaFighterState.spawning:
          return _plasmaFighterAnimation.spawningAnimation(gameRef, spriteSize);
        case PlasmaFighterState.exploding:
          return _plasmaFighterAnimation.explodingAnimation(gameRef, spriteSize);
        default:
          return _plasmaFighterAnimation.idleAnimation(gameRef, spriteSize);
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _plasmaFighterAnimation.idleAnimation(gameRef, spriteSize);
    }
  }

}