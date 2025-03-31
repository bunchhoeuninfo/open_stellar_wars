

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/players/player_movement.dart';
import 'package:open_stellar_wars/core/services/players/player_shooting.dart';
import 'package:open_stellar_wars/core/services/players/player_shooting_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_state.dart';
import 'package:open_stellar_wars/core/services/players/player_movement_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_state_impl.dart';
import 'package:open_stellar_wars/core/state/player_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class Player extends SpriteAnimationComponent with HasGameRef<StellarWarGame>, CollisionCallbacks, GestureHitboxes   {

  int hitPoints = 2;    // Default hit points

  Player({required Vector2 position, int? customHitPoints})
      : super(size: Vector2(45, 55), position: position) // Fixed position
      {
        if (customHitPoints != null) {
          hitPoints = customHitPoints;    // Set custom hit points if provided
        }
      }

  final double moveSpeed = 200;
  final double jumpForce = -400;
  final double gravity = 600;
  double velocityY = 0;
  bool isGrounded = false;
  bool isScreenVertical = true;

/*
  double _lastShotTime = 0;
  final double _bulletSpeed = 300;
  final double _fireRate = 0.3;    // Time between shots
  */

  final IPlayerMovement _playerMovementManager = PlayerMovementImpl();
  final IPlayerState _playerStateManager = PlayerStateImpl();

  late IPlayerShooting _playerShooting;
  

  final _spriteSize = Vector2(45,55);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    try {
      LogUtil.debug('Player sprite loaded succesfully');

      _playerStateManager.stateNotifier.value = PlayerState.playing;
      animation = _playerMovementManager.applyPlayerAnimationByState(gameRef, this, _spriteSize);
      await _playerMovementManager.setMovementBounds(gameRef);
      
      _playerShooting = PlayerShootingImpl(
        gameRef: gameRef,
        fireRate: 0.3,
        bulletSpeed: 300,
      );

      add(RectangleHitbox());
      priority = 600;
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void update(double dt) {
    //LogUtil.debug('Called update method...');
    super.update(dt);
    _playerMovementManager.applyMoveUpGravity(dt, this, gameRef);
    animation = _playerMovementManager.applyPlayerAnimationByState(gameRef, this, _spriteSize);
    // Check if enough time has passed to fire another bullet
    _playerShooting.update(dt);
  }

  void fire({bool isSpecial = false}) {
    if (isSpecial) {
      _playerShooting.fireSpecialBullet(position, size);
    } else {
      _playerShooting.fireNormalBullet(position, size);
    }
  }

  void moveLeft() {
    LogUtil.debug('Player moved left...');
    _playerMovementManager.moveLeft();
  }

  void moveUp() {
    LogUtil.debug('Player moved up...');
    _playerMovementManager.moveUp();
  }

  void moveDown() {
    LogUtil.debug('Player moved down...');
    _playerMovementManager.moveDown();
  }

  void moveRight() {
    LogUtil.debug('Player moved right...');
    _playerMovementManager.moveRight();
  }

  void onLeftTapUp() {
    LogUtil.debug('Player onLeftTapUp...');
    _playerMovementManager.onLeftTapUp();
  }

  void onRighttapUp() {
    LogUtil.debug('Player onRighttapUp...');
    _playerMovementManager.onRighttapUp();
  }

  void onUpTapUp() {
    LogUtil.debug('Player onUpTapUp...');
    _playerMovementManager.onUpTapUp();
  }

  void onDownTapUp() {
    LogUtil.debug('Player onDownTapUp...');
    _playerMovementManager.onDownTapUp();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

  void explode() {
    // Add explosion animation or effects here
    removeFromParent();
  }

  void takeHit(int damage) {
    hitPoints -= damage;
    if (hitPoints <= 0) {
      explode();
    }
  }

}