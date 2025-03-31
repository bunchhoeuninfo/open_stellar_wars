
import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IPlayerAnimation {
   SpriteAnimation walkingAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation jumpingAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation idleAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation upwardAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation moveLeftAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation moverightAnimation(StellarWarGame gameRef, Vector2 spriteSize);
   SpriteAnimation flyingAnimation(StellarWarGame gameRef, Vector2 spriteSize);
  
}