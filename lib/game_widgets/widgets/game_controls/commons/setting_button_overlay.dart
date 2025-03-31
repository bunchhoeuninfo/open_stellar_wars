
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/setting_screen.dart';

class SettingButtonOverlay extends StatelessWidget {

  final StellarWarGame game;
  final IGameService _gameServiceManager = GameServiceImpl();
  final IGameState _gameStateManager = GameStateImpl();
  SettingButtonOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return !game.overlays.isActive('restart') ? _buildTopRight(context) : Container();
  }

  Positioned _buildTopRight(BuildContext context) {
    LogUtil.debug('Start building setting button overlay at the top right corner.');
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          _gameServiceManager.pauseGame(game);
          //_gameStateManager.stateNotifier.value = GameState.gameOver;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingScreen(gameRef: game,)),
          );
        },
        child: const Icon(Icons.settings, size: 30, color: Colors.white,),
      ),
    );
  }

}