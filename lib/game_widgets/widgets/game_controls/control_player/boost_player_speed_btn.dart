
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class BoostPlayerSpeedBtn extends StatelessWidget {

  BoostPlayerSpeedBtn({super.key, required this.game});

  final StellarWarGame game;
  final IGameState _gameStateManager = GameStateImpl();

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<StellarWarGameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == StellarWarGameState.playing ?
          _buildBoostSpeedBtn(context)
        : Container();
      }
    );
  }

  Align _buildBoostSpeedBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight, // Align to the bottom-right of the screen
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 100), // Add padding for spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _boostSpeedBtn(),
          ],
        ),
      ),
    );
  }

  GestureDetector _boostSpeedBtn() {
    return GestureDetector(
      onTap: () {
        LogUtil.debug('Click boost player speed button control');
      },
      child: const Icon(Icons.speed, size: 50, color: Colors.white,),
    );
  }

}