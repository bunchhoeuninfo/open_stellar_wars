

import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_service.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class LevelUpOverlay extends StatelessWidget {
  final StellarWarGame game;
  final IGameService _gameServiceManager = GameServiceImpl();
  final LiveScoreServiceImpl _liveScoreService = LiveScoreServiceImpl();

  LevelUpOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _buildLevelUpOverlay();
  }

  Center _buildLevelUpOverlay() {
    LogUtil.debug('Inside build _buildLevelUpCongrateOverlay');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              _buildRow(null, _liveScoreService.encouragementNotifier, Colors.amber),
              const SizedBox(height: 5),
              _buildRow('Player', _liveScoreService.playerNameNotifier, Colors.yellow),
              _buildRow('Level', _liveScoreService.levelNotifier, Colors.blue),
              const SizedBox(height: 20,),
            ],
          ),
          // Row for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              ElevatedButton(
                onPressed: () {                
                  _gameServiceManager.startGame(game);                                    
                  _liveScoreService.resetScore();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),              
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow<T>(String? label, ValueNotifier<T> notifier, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label != null ? '$label: ' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

}