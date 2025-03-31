
import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/players/player_animation.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class PlayerAnimationServiceImpl implements IPlayerAnimation {
  @override
  SpriteAnimation idleAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    //LogUtil.debug('Player is idle');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/spaceships/spaceship_idle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation jumpingAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is jumping');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_jumping.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation walkingAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is walking');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_post_jump.png'),  // sprite sheet image
        SpriteAnimationData.sequenced(
          amount: 3, // Number of frames in the sprite sheet
          stepTime: 0.1,  // Time per frame (adjust for walk speed)
          textureSize: spriteSize // Size of each frame
        ),
      );
  }
  
  @override
  SpriteAnimation upwardAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is moving upward');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_upward.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation moveLeftAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is moving left');
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('players/kitties/kitty_move_left.png'), 
      SpriteAnimationData.sequenced(
        amount: 1, 
        stepTime: 0.1, 
        textureSize: spriteSize,
      ),
    );
  }
  
  @override
  SpriteAnimation moverightAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is moving right');
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('players/kitties/kitty_move_right.png'), 
      SpriteAnimationData.sequenced(
        amount: 1, 
        stepTime: 0.1, 
        textureSize: spriteSize
      ),
    );
  }
  
  @override
  SpriteAnimation flyingAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is flying');
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('players/spaceships/spaceship_flying.png'), 
      SpriteAnimationData.sequenced(
        amount: 2, 
        stepTime: 0.2, 
        textureSize: spriteSize
      ),
    );
  }

}