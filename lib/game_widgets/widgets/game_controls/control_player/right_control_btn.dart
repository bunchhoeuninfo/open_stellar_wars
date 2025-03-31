
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class RightControlBtn extends StatelessWidget {

  RightControlBtn({super.key, required this.game});

  final StellarWarGame game;
  final IGameState _gameStateManager = GameStateImpl();


  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start RightControlButton build');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == StellarWarGameState.playing ?
          _buildRightControl(context)
        : Container();
      }
    );
  }

  Align _buildRightControl(BuildContext context) {
    return Align(
      alignment: const Alignment (-1, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 120, bottom: 40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _rightButton(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _rightButton() {
    return GestureDetector(
      onTapDown: (_) {
        game.player.moveRight();
        LogUtil.debug('Moving right click.....');
      },
      onTapUp: (_) {
        LogUtil.debug('onRighttapUp....');
        game.player.onRighttapUp();
      },
      /*
    onTap: () {
      LogUtil.debug('Click right control');
      //_playerMovementManager.moveRight();
      game.player.moveRight();
    },*/
      child: const Icon(Icons.arrow_forward, size: 50, color: Colors.white),
    ); 
  }

}