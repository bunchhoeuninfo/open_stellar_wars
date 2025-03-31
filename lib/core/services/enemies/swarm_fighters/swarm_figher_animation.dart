import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class ISwarmFighterAnimation {
  SpriteAnimation idleAnimation(StellarWarGame gameRef, Vector2 spriteSize);
  SpriteAnimation spawningAnimation(StellarWarGame gameRef, Vector2 spriteSize);
  SpriteAnimation explodingAnimation(StellarWarGame gameRef, Vector2 spriteSize);
}