
import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_figher_animation.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class SwarmFighterAnimationImpl implements ISwarmFighterAnimation {
  @override
  SpriteAnimation idleAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('enemies/swarm_fighters/swarm_fighter.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: Vector2(spriteSize.x, spriteSize.y), 
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error while creating idle animation');
    }
  }

  @override
  SpriteAnimation spawningAnimation(StellarWarGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('enemies/swarm_fighters/swarm_fighter.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: Vector2(spriteSize.x, spriteSize.y), 
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error while creating idle animation');
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
          textureSize: spriteSize,    // Explosion size
          loop: false,  // Explosion should play once and disappear
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error while creating idle animation');
    }
  }

}