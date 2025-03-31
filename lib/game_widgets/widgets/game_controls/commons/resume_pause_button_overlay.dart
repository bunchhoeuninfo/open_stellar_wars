
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/players/player_state.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_state_impl.dart';
import 'package:open_stellar_wars/core/state/player_state.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class ResumePauseButtonOverlay extends StatelessWidget {
  final StellarWarGame gameRef;
  final IGameService _gameServiceManager = GameServiceImpl();
  final IGameState _gameStateManager = GameStateImpl();
  final IPlayerState _playerStateManager = PlayerStateImpl();

  ResumePauseButtonOverlay({super.key, required this.gameRef}) ;

  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder<StellarWarGameState>(
      valueListenable: _gameStateManager.stateNotifier,
      builder: (context, state, child) {
        LogUtil.debug('Building play pause button overlay, state: $state');
        LogUtil.debug('Game state: ${_gameStateManager.stateNotifier.value}');
        if (state == StellarWarGameState.paused) {
          return _buildTopCenter(context, false);
        } else if (state == StellarWarGameState.resumed || state == StellarWarGameState.playing) {
          return _buildTopCenter(context, true);
        }
        return Container();
      },
    );
  }

  Align _buildTopCenter(BuildContext context, bool isPaused) {
    return Align(
      alignment: Alignment.topRight,    // Move to the right side
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isPaused ?  _buildPauseButton() : _buildPlayButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildPauseButton() {
    return GestureDetector(
      onTap: () {
        _gameStateManager.stateNotifier.value = StellarWarGameState.paused;
        _playerStateManager.stateNotifier.value = PlayerState.paused;
      },
      child: const Icon(Icons.pause, size: 50, color: Colors.white),
    );
  }

  GestureDetector _buildPlayButton() {
    return GestureDetector(
      onTap: () {
        _gameStateManager.stateNotifier.value = StellarWarGameState.resumed;
        _playerStateManager.stateNotifier.value = PlayerState.playing;
        _gameServiceManager.resumeGame(gameRef);
      },
      child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
    );
  }
}

