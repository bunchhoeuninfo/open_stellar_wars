


import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IGameService {

  void setupBackground(StellarWarGame game);
  void setupDynamicBackground(StellarWarGame game);

  void gameOver(StellarWarGame game);
  void restartGame(StellarWarGame game);
  void startGame(StellarWarGame game);
  void pauseGame(StellarWarGame game);
  void addEntities(StellarWarGame game);
  void resumeGame(StellarWarGame game); 
  void levelUp(StellarWarGame game);
  void onGameStateChanged(double dt, StellarWarGameState state, StellarWarGame game);
  
}