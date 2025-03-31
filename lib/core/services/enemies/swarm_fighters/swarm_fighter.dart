import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/swarm_fighter.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class ISwarmFighter {
  void move();
  void attack();
  void die();
  void spawnSwarmFighterEnemies(StellarWarGame gameRef, double dt);
  void setSwarmFighterSpawnBounds();
  SpriteAnimation applySwarmFighterAnimation(StellarWarGame gameRef, Vector2 spriteSize);
  void applyGravity(double dt, StellarWarGame gameRef, SwarmFighter swarmFighter);
}