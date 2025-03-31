
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class JumpControlBtn extends StatelessWidget {
  JumpControlBtn({super.key, required this.game});

  final StellarWarGame game;
  final IGameState _gameStateManager = GameStateImpl();


  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start building jump control button');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<StellarWarGameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == StellarWarGameState.playing
          ? _buildBottomJump(context)
          : Container();
      }
    );
  }

  Align _buildBottomJump(BuildContext context) {
    return Align(
      alignment: const Alignment (1, 1), // Bottom-right
      child: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),  // adjust spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bottomJump(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _bottomJump() {
    return GestureDetector(
      onTap: () {
        LogUtil.debug('message: Jump button pressed');
        //game.player.fireBullet();
      },
      //child: const Icon(Icons., size: 50, color: Colors.amber,),
      child: const FaIcon(FontAwesomeIcons.superpowers, size: 50, color: Colors.amber,),
    );
  }

}