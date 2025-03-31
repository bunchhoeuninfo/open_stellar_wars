
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class UpControlBtn extends StatelessWidget {

  UpControlBtn({super.key, required this.game});

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
        padding: const EdgeInsets.only(left: 70, bottom: 90),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _upButton(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _upButton() {
    return GestureDetector(
      onTapDown: (_) {
        game.player.moveUp();
        LogUtil.debug('Moving up click.....');
      },
      onTapUp: (_) {
        LogUtil.debug('onUptapUp....');
        game.player.onUpTapUp();
      },
      child: const Icon(Icons.arrow_upward, size: 50, color: Colors.white),
    ); 
  }

}