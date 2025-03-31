
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/players/player_movement.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_movement_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class LeftControlButton extends StatelessWidget {
  LeftControlButton({super.key, required this.game});

  final StellarWarGame game;
  final IGameState _gameStateManager = GameStateImpl();
  final IPlayerMovement _playerMovementManager = PlayerMovementImpl();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start LeftControlButton build');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<StellarWarGameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == StellarWarGameState.playing ?
          _buildLeftCenter(context)
        :  Container();
      });
  }

  Align _buildLeftCenter(BuildContext context) {
    return Align(
      alignment: const Alignment (-1, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _leftButton(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _leftButton() {
    return GestureDetector(
      onTapDown: (_) {
        game.player.moveLeft();
        LogUtil.debug('onTap _leftButton');
      },
      onTapUp: (details) {
        LogUtil.debug('onTapUp....');
        game.player.onLeftTapUp();
      }
    /*onTap: () {
      LogUtil.debug('Click move left button');
      //_playerMovementManager.moveLeft();
      game.player.moveLeft();
    }*/,
      child: const Icon(Icons.arrow_back, size: 50, color: Colors.white),
    ); 
  }

}