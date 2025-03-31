
import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/components/players/player.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IPlayerMovement {
  
  // Apply gravity to the player
  void applyGravityHorizontal(double dt, Player player, StellarWarGame gameRef);
  void applyGravityVertical(double dt, Player player, StellarWarGame gameRef);
  void applyGravity(double dt, Player player, StellarWarGame gameRef);
  void applyMoveUpGravity(double dt, Player player, StellarWarGame gameRef);

  void jumpInIdleState(StellarWarGame gameRef);
  void jump(StellarWarGame gameRef);
  //void handleTap(Vector2 tapPosition, EndlessRunnerGame gameRef);
  void resetPosition(StellarWarGame gameRef, Player player);
  void initPosition(StellarWarGame gameRef, Player player);
  
  // set the movement bounds for the player
  void setMovementBoundsHorizontal(StellarWarGame gameRef);
  void setMovementBoundsVertical(StellarWarGame gameRef);
  Future<void> setMovementBounds(StellarWarGame gameRef);


  void moveUpward();

  void moveLeft();
  void moveRight();
  void moveUp();
  void moveDown();
  void stopMoving();

  void onLeftTapUp();
  void onUpTapUp();
  void onDownTapUp();
  void onRighttapUp();

  void landingStoneJump(PositionComponent other, StellarWarGame gameRef);
  void handleCollisionEnd(PositionComponent other, StellarWarGame gameRef);

  SpriteAnimation applyPlayerAnimationByState(StellarWarGame gameRef, Player player, Vector2 spriteSize);



}