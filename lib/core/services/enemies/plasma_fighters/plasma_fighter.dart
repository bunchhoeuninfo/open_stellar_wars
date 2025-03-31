import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/components/enemies/plasma_fighter.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IPlasmaFighter {
  void setPlasmaFighterSpawnBounds();
  void spawnPlasmaFighterEnemies(StellarWarGame gameRef, double dt);
  void applyGravity(double dt, StellarWarGame gameRef, PlasmaFighter plasmaFrigate);
  SpriteAnimation applyPlasmaFighterAnimation(StellarWarGame gameRef, Vector2 spriteSize);
}