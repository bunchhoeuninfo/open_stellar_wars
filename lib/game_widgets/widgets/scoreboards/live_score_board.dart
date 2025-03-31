

import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_manager.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier_impl.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_service.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class LiveScoreBoard extends StatelessWidget {
  LiveScoreBoard({super.key});

  final ILiveScoreManager _liveScoreManager = LiveScoreServiceImpl();
  final ValueNotifier<bool> _resetNotifier = ValueNotifier<bool>(false);
  final IPlayerDataNotifier _playerDataNotifierManager = PlayerDataNotifierImpl();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _liveScoreBoard();
    //return _congrateStack();
  }

  Positioned _liveScoreBoard() {
    LogUtil.debug('Build live score board position to display score: ${_liveScoreManager.scoreNotifier}, high score: ${_liveScoreManager.highScoreNotifier}, level: ${_liveScoreManager.levelNotifier}');
    return Positioned(
      top: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //_buildRow('Player1', _liveScoreManager.playerNameNotifier, Colors.amber),
          ValueListenableBuilder<PlayerData>(
            valueListenable: _playerDataNotifierManager.playerDataNotifier, 
            builder: (context, playerData, child) {
              return _buildScoreItem('Player', playerData.playerName, Colors.blue);
            }
          ),
          //_buildRow('Score', _liveScoreManager.scoreNotifier, Colors.yellow),          
          ValueListenableBuilder(
            valueListenable: _liveScoreManager.scoreNotifier, 
            builder: (context, score, child) {
              return _buildScoreItem('Score', score, Colors.yellow);
            }
          ),
          _buildRow('High Score', _liveScoreManager.highScoreNotifier, Colors.green),   
                 
          
          _buildRow('Level', _liveScoreManager.levelNotifier, Colors.blue),
          
        ],
      ),
    );
  }

  Widget _buildScoreItem<T>(String? label, dynamic value, Color valueColor) {
    LogUtil.debug('Inside _buildScoreItem');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRow<T>(String label, ValueNotifier<T> notifier, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

}