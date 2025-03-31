
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/players/player_animation.dart';
import 'package:open_stellar_wars/core/services/players/player_movement.dart';
import 'package:open_stellar_wars/core/services/players/player_state.dart';
import 'package:open_stellar_wars/core/services/players/player_animation_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_state_impl.dart';
import 'package:open_stellar_wars/core/state/player_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/players/player.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class PlayerMovementImpl implements IPlayerMovement {
  final double _jumpForce = -250;
  final double _upwardForce = -400;
  final double _gravity = 600;
  final double _moveSpeed = 500; // Movement speed
  final double _initGameSpeed = 100;

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;
  bool isIdle = false;

  bool _decelerating = false;


  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final IPlayerState _playerStateManager = PlayerStateImpl();
  final IPlayerAnimation _playerAnimationManager = PlayerAnimationServiceImpl();

  @override
  void setMovementBoundsHorizontal(StellarWarGame gameRef) {
    _minX = gameRef.size.x * 0.05;
    _maxX = gameRef.size.x * 0.89;
  }

  @override
  void applyGravityHorizontal(double dt, Player player, StellarWarGame gameRef) {
    //LogUtil.debug('Called here position');
    final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    const topLevel = 0.0;

    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
      
    }    
    
    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
    }

    // Present player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel;
      _velocityY = 0;
    }

    //LogUtil.debug('Player Y: ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');

    if (_decelerating) {
      LogUtil.debug('_decelerating->$_decelerating, _velocityX->$_velocityX');
      const double friction = 2500; // Adjust for smooth stopping effect
      if (_velocityX < 0) {
        _velocityX += friction * dt; // Gradually increase velocity towards 0
        if (_velocityX > 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      } else {
        _velocityX -= friction * dt; // Gradually decrease velocity towards 0
        if (_velocityX < 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      }
    }

    //LogUtil.debug('_velocityX->$_velocityX');
    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    player.position.x = player.position.x.clamp(_minX, _maxX);
  }

  @override
  void jump(StellarWarGame gameRef) {
    _velocityY = _jumpForce;
    
    if (_playerStateManager.stateNotifier.value != PlayerState.jumping) {
      _playerStateManager.stateNotifier.value = PlayerState.jumping;
    }

  }

  @override
  void moveLeft() {
    if (_playerStateManager.stateNotifier.value != PlayerState.moveLeft) {
      _playerStateManager.stateNotifier.value = PlayerState.moveLeft;
    }

    _velocityX = -_moveSpeed; // Move left
    _velocityY = 0;
    isGrounded = true;
    _decelerating = false;
  }

  @override
  void moveRight() {
    if (_playerStateManager.stateNotifier.value != PlayerState.moveRight) {
      _playerStateManager.stateNotifier.value = PlayerState.moveRight;
    }

    _velocityX = _moveSpeed; // Move right
    _velocityY = 0;
    isGrounded = true;
    _decelerating = false;
  }

  @override
  void stopMoving() {
    _velocityX = 0; // Stop movement
  }
  
  @override
  void resetPosition(StellarWarGame gameRef, Player player) {
    LogUtil.debug('Try to reset player position');
    final screenX = gameRef.size.x * 0.5;
    final groundLevel = gameRef.size.y / 2;
    //player.position.x = screenLeftEdge;
    player.position = Vector2(screenX, groundLevel);
    _velocityY = 0;
    _velocityX = 0;
    isGrounded = true;
    //player.position.x += _velocityX * dt;
    //player.position.x = player.position.x.clamp(_minX, _maxX);
    LogUtil.debug('Try to reset player position ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');
  }

  @override
  void onLeftTapUp() {
    // When the user lifts their finger, set _velocityX to 0, stopping movement.
    //_velocityX = 0;  // Stop moving when the tap is released
    _decelerating = true;
  }
  
  
  @override
  void onRighttapUp() {
    //top gradually when the tap is released
    _decelerating = true;
  }
  
  @override
  void initPosition(StellarWarGame gameRef, Player player) {
    final screenLeftEdge = gameRef.size.x * 0.5;
    final groundLevel = gameRef.size.y / 2;
    player.position = Vector2(screenLeftEdge, groundLevel);
    _velocityY = 0;
    isGrounded = true;
  }
  
  @override
  void moveUpward() {
    _velocityY = _upwardForce;
    isGrounded = false;
  }
  
  @override
  void setMovementBoundsVertical(StellarWarGame gameRef) {
    _minY = gameRef.size.y * 0.05;  // 5% from the top
    _maxY = gameRef.size.y * 0.89;  // 89% from the top (leaving space at the bottom)
  }
  
  @override
  void applyGravityVertical(double dt, Player player, StellarWarGame gameRef) {
    //LogUtil.debug('Called here position');
    final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    const topLevel = 0.0;

    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
      
    }    
    
    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
    }

    // Present player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel;
      _velocityY = 0;
    }

    //LogUtil.debug('Player Y: ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');

    if (_decelerating) {
      LogUtil.debug('_decelerating->$_decelerating, _velocityX->$_velocityX');
      const double friction = 2500; // Adjust for smooth stopping effect
      if (_velocityX < 0) {
        _velocityX += friction * dt; // Gradually increase velocity towards 0
        if (_velocityX > 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      } else {
        _velocityX -= friction * dt; // Gradually decrease velocity towards 0
        if (_velocityX < 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      }
    }

    //LogUtil.debug('_velocityX->$_velocityX');
    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    player.position.y = player.position.y.clamp(_minY, _maxY);
  }
  
  @override
  Future<void> setMovementBounds(StellarWarGame gameRef) async {
    try {
      Vector2 screenSize = _getScreenSize();
      await Future.delayed(const Duration(microseconds: 100), () {
        _minX = 0;  // Left edge of the screen        
        _maxX = screenSize.x - gameRef.player.size.x;  // Right edge of the screen        
        //LogUtil.debug('Player position _minX: $_minX, _maxX: $_maxX');
        _minY = 0;  // Top of the screen
        _maxY = screenSize.y;  // Bottom of the screen
      });
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  Vector2 _getScreenSize() {
    final Size screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    
    return Vector2(screenSize.width, screenSize.height);
  }
  
  @override
  void applyGravity(double dt, Player player, StellarWarGame gameRef) {
    //LogUtil.debug('Called here position');
    //final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    final groundLevel = _maxY - gameRef.player.size.y; // Move ground to bottom of the screen
    const topLevel = 0.0;
    const int currentLevel  = 1;
    

    if (!isGrounded) {
      _velocityY += _getGameSpeed(currentLevel) * dt;  // Accelerate downwards
      player.position.y += _velocityY * dt;  // Move player downwards
    }    
    
    // Check if the player has hit the ground
    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
      _playerStateManager.stateNotifier.value = PlayerState.idle;
    } else {
      isGrounded = false;   // Player is in the air
    }

    // Present player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel;  // Lock to the top
      _velocityY = 0;
    }

    //LogUtil.debug('Player Y: ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');

    if (_decelerating) {
      LogUtil.debug('_decelerating->$_decelerating, _velocityX->$_velocityX');
      const double friction = 2500; // Adjust for smooth stopping effect
      if (_velocityX < 0) {
        _velocityX += friction * dt; // Gradually increase velocity towards 0
        if (_velocityX > 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      } else {
        _velocityX -= friction * dt; // Gradually decrease velocity towards 0
        if (_velocityX < 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      }
    }

    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    //LogUtil.debug('Player position before clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');

    // Ensure the player stays within the screen bounds
    player.position.x = player.position.x.clamp(_minX, _maxX);
    //LogUtil.debug('Player position after clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');
    player.position.y = player.position.y.clamp(_minY, _maxY);

  }  

  double _getGameSpeed(int level) {
    return 100 + (level * 20); // Adjust the speed increase per level
  }
  
  @override
  void landingStoneJump(PositionComponent other, StellarWarGame gameRef) {
    /*if (other is StoneSurfaceToLand) {
      LogUtil.debug('Player is landing stone surface');
      _velocityY = 0;
      isGrounded = true;
      _playerStateManager.stateNotifier.value = PlayerState.idle;
    }*/
  }
  
  @override
  void handleCollisionEnd(PositionComponent other, StellarWarGame gameRef) {
    /*if (other is StoneSurfaceToLand) {
      isGrounded = false; // Player is in the air
      
    }*/
  }
  
  @override
  SpriteAnimation applyPlayerAnimationByState(StellarWarGame gameRef, Player player, Vector2 spriteSize) {
    PlayerState state = _playerStateManager.stateNotifier.value;
    //LogUtil.debug('Player state -> $state');
    try {
      if (state == PlayerState.idle) {
        return _playerAnimationManager.idleAnimation(gameRef, spriteSize);
      } else if (state == PlayerState.jumping) {
        return _playerAnimationManager.jumpingAnimation(gameRef, spriteSize);
      } else if (state == PlayerState.moveLeft) {
        return _playerAnimationManager.moveLeftAnimation(gameRef, spriteSize);
      } else if (state == PlayerState.moveRight) {
        return _playerAnimationManager.moverightAnimation(gameRef, spriteSize);
      } else if (state == PlayerState.jumping) {
        return _playerAnimationManager.jumpingAnimation(gameRef, spriteSize);
      } else if (state == PlayerState.playing) {
        return _playerAnimationManager.flyingAnimation(gameRef, spriteSize);
      }
      return _playerAnimationManager.idleAnimation(gameRef, spriteSize);

    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _playerAnimationManager.idleAnimation(gameRef, spriteSize);
    }
  }
  
  @override
  void applyMoveUpGravity(double dt, Player player, StellarWarGame gameRef) {
    final idlePosition = _maxY / 2; // Player idle position
    const topLevel = 0.0;
    const double gravity = 2000; // Gravity strength

     // Apply gravity effect
    _velocityY += gravity * dt;  // Pull player down
    player.position.y += _velocityY * dt;  // Move player

    // Prevent player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel; // Lock the top 
      _velocityY = 0;
    }

    //LogUtil.debug('Player Y: ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');

    if (_decelerating) {
      LogUtil.debug('_decelerating->$_decelerating, _velocityX->$_velocityX');
      const double friction = 2500; // Adjust for smooth stopping effect
      if (_velocityX < 0) {
        _velocityX += friction * dt; // Gradually increase velocity towards 0
        if (_velocityX > 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      } else {
        _velocityX -= friction * dt; // Gradually decrease velocity towards 0
        if (_velocityX < 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      }
    }

    if (player.position.y >= idlePosition) {
      player.position.y = idlePosition;
      _velocityY = 0;
      isIdle = true;
      _playerStateManager.stateNotifier.value = PlayerState.idle;
      
      // Reset background speed
      /*for (var bg in gameRef.backgrounds) {
        bg.currentSpeed = 0;
      }*/
    } else {
      isIdle = false;   // Player is in the air
    }

    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    //LogUtil.debug('Player position before clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');

    // Ensure the player stays within the screen bounds
    player.position.x = player.position.x.clamp(_minX, _maxX);
    //LogUtil.debug('Player position after clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');
    player.position.y = player.position.y.clamp(_minY, _maxY);


  }
  
  @override
  void jumpInIdleState(StellarWarGame gameRef) {
    LogUtil.debug('Jump in idle state -> isIdle: $isIdle');
    if (isIdle) {  // Ensure player can only jump when idle
      _velocityY = -800; // Set initial jump speed (negative moves up)
      isIdle = false;
      _playerStateManager.stateNotifier.value = PlayerState.jumping;

      // Move the background downward
      /*for (var bg in gameRef.backgrounds) {
        bg.currentSpeed = 100;
      }*/
    }
    
  }
  
  @override
  void moveDown() {
    // TODO: implement moveDown
  }
  
  @override
  void moveUp() {
    if (_playerStateManager.stateNotifier.value != PlayerState.moveUp) {
      _playerStateManager.stateNotifier.value = PlayerState.moveUp;
    }

    _velocityY = -_moveSpeed; // Move Up
    _velocityX = 0; // Stop horizontal movement if needed
    isGrounded = false; // If moving up, player is not on the ground
    _decelerating = false;
  }
  
  @override
  void onDownTapUp() {
    _decelerating = true;
  }
  
  @override
  void onUpTapUp() {
    _decelerating = true;
  }
  
}