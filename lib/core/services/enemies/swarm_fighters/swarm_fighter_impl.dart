import 'dart:math';

import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_figher_animation.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_state.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_animation_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_state_impl.dart';
import 'package:open_stellar_wars/core/state/swarm_fighter_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/core/utils/screen_utils.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/swarm_fighter.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class SwarmFighterImpl implements ISwarmFighter {

  // Swarm fighter  
  final double _swarmSpawnInterval = 5.2; // swarm fighter spawn interval every 5.2 seconds
  double _swarmTimer = 0;

  

  final double _spawnSpeed = 80;    // Speed of swarm fighter movement

  bool isGrounded = false;
  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final Random _random = Random();
  final ISwarmFighterState _swarmFighterState = SwarmFighterStateImpl();
  final ISwarmFighterAnimation _swarmFighterAnimation = SwarmFighterAnimationImpl();

  @override
  void attack() {
    // TODO: implement attack
  }

  @override
  void die() {
    // TODO: implement die
  }

  @override
  void move() {
    // TODO: implement move
  }

  @override
  void spawnSwarmFighterEnemies(StellarWarGame gameRef, double dt) {
    _swarmTimer += dt;
    try {
      //LogUtil.debug('Try to spawn swarmFighter sprite...');
      if (_swarmTimer >= _swarmSpawnInterval) {
        _swarmTimer = 0;
        Vector2 screenSize = ScreenUtils.getScreenSize();
        _minX = 0;
        _maxX = screenSize.x;
        _minY = 0;
        _maxY = screenSize.y;

        // Define the number of columns and rows of the grid
        int totalColumns = 5;
        int selectedColumn = _random.nextInt(totalColumns); // pick a column randomly

        // Calculate the X position of the selected column
        double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
        double columnX = _minX + (selectedColumn * columnSpacing);

        SwarmFighter swarmFighter = SwarmFighter(Vector2(columnX, _minY), null);
        gameRef.add(swarmFighter);
      }
    } catch (e) {
      LogUtil.error('Exception in spawnSwarmFighterEnemies $e');
    }
    
  }
  
  @override
  void setSwarmFighterSpawnBounds() {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;
      _maxY = screenSize.y;
    } catch (e) {
      LogUtil.error('Exception in setSwarmFighterSpawnBounds $e');
    }
  }
  
  @override
  void applyGravity(double dt, StellarWarGame gameRef, SwarmFighter swarmFighter) {
    try {
      LogUtil.debug('Try to apply gravity to swarmFighter sprite...');
      swarmFighter.position.y += _spawnSpeed * dt;
      _swarmFighterState.stateNotifier.value = SwarmFighterState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y - swarmFighter.size.y;
      if (swarmFighter.position.y > groundLevel) {        
        _swarmFighterState.stateNotifier.value = SwarmFighterState.hitGround;
        swarmFighter.removeFromParent();
      }

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  SpriteAnimation applySwarmFighterAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    SwarmFighterState swarmFighterState = _swarmFighterState.stateNotifier.value;
    try {
      LogUtil.debug('Try to apply Plasma Frigate animation...');
      switch (swarmFighterState) {
        case SwarmFighterState.idle:
          return _swarmFighterAnimation.idleAnimation(gameRef, spriteSize);
        case SwarmFighterState.spawning:
          return _swarmFighterAnimation.spawningAnimation(gameRef, spriteSize);
        case SwarmFighterState.exploding:
          return _swarmFighterAnimation.explodingAnimation(gameRef, spriteSize);
        default:
          return _swarmFighterAnimation.idleAnimation(gameRef, spriteSize);
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _swarmFighterAnimation.idleAnimation(gameRef, spriteSize);
    }
  }

}