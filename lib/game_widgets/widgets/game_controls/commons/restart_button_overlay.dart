

import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_manager.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_service.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class RestartButtonOverlay extends StatelessWidget {
  final StellarWarGame game;
  final GameServiceImpl _gameServiceManager = GameServiceImpl();
  final ILiveScoreManager _liveScoreManager = LiveScoreServiceImpl();
  final IGameState _gameStateManager = GameStateImpl();

  RestartButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Game Over',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _gameServiceManager.restartGame(game);
              _liveScoreManager.saveLiveScoreBoard();
             // game.add(PlayPauseButton());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Tap to Restart',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resumeGame() {
    LogUtil.debug('Start method restartGame...');
    //game.add(PlayPauseButton());
    //game.gameStateManager.setState(GameState.playing);
    _gameStateManager.stateNotifier.value = StellarWarGameState.playing;
    game.resumeEngine();  //Resume the game loop              
    game.isFirstRun = false;        
    game.overlays.remove('restart');    
    
    // Remove all objects from game screen
    //game.children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
    //game.children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
    //game.children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());

  }
}