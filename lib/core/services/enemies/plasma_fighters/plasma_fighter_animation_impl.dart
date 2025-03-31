
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_animation.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class PlasmaFighterAnimationImpl implements IPlasmaFighterAnimation {
  @override
  SpriteAnimation idleAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('enemies/plasma_fighters/plasma_fighter.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 1, 
          textureSize: spriteSize)
      );
    } catch (e) {
      LogUtil.error('Exception in idleAnimation $e');
      throw ('Exception in idleAnimation $e');
    }
  }

  @override
  SpriteAnimation spawningAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('enemies/plasma_fighters/plasma_fighter.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 1, 
          textureSize: spriteSize)
      );
    } catch (e) {
      LogUtil.error('Exception in spawningAnimation $e');
      throw ('Exception in spawningAnimation $e');
    }
  }
  
  @override
  SpriteAnimation explodingAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('explosions/enemy_explode.png'), 
        SpriteAnimationData.sequenced(
          amount: 6, 
          stepTime: 0.05, 
          textureSize: spriteSize,  // Explosion size
          loop: false,  // Explosion should play once and disappear
          ),
      );
    } catch (e) {
      LogUtil.error('Exception in spawningAnimation $e');
      throw ('Exception in spawningAnimation $e');
    }
  }

}