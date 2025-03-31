


import 'package:flutter/material.dart';
import 'package:open_stellar_wars/constants/game_constant.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier_impl.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_service.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/signup/player_signup.dart';

class StartSignupButtonOverlay extends StatelessWidget {
  final StellarWarGame game;
  final IGameService _gameServiceManager = GameServiceImpl();
  final LiveScoreServiceImpl _liveScoreService = LiveScoreServiceImpl();
  final IGameState _gameStateManager = GameStateImpl();
  final IPlayerAuth _playerAuthManager = PlayerAuthImpl();
  final IPlayerDataNotifier _playerDataNotifierManager = PlayerDataNotifierImpl();
  
  StartSignupButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method, listening _gameStateManager.stateNotifier -> ${_gameStateManager.stateNotifier.value} ');
    return _buildPlayerProgresInfo(context);
  }

  FutureBuilder _futureBuilder() {
    LogUtil.debug('Inside future builder');
    return FutureBuilder(
      future: _liveScoreService.loadGameProgress(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading progress'),);
        } else {
          LogUtil.debug('Inside future builder else');
          _gameStateManager.stateNotifier.value = StellarWarGameState.menu;
          return _buildPlayerProgresInfo(context);
        }    
      }
    );
  }

  Center _buildPlayerProgresInfo(BuildContext context) {
    LogUtil.debug('Inside build player progress info method');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              _buildRow(null, _liveScoreService.encouragementNotifier, Colors.amber),
              const SizedBox(height: 5),              
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Player', playerData.playerName, Colors.blue);
                },
              ),
              const SizedBox(height: 5),
              //_buildRow('Top Score', _liveScoreService.highScoreNotifier, Colors.green),
              //_buildItem('Top Score', _playerDataNotifierManager.playerDataNotifier.value.topScore, Colors.yellow),
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Top Score', playerData.topScore, Colors.yellow);
                },
              ),
              const SizedBox(height: 5,),
              //_buildRow('Level', _liveScoreService.levelNotifier, Colors.blue),
              //_buildItem('Level', _playerDataNotifierManager.playerDataNotifier.value.level, Colors.green),
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Level', playerData.level, Colors.green);
                },
              ),

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
                  _gameStateManager.stateNotifier.value = StellarWarGameState.playing;                         
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),   
              const SizedBox(width: 20), 
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  //return _buildItem('Player', playerData.playerName, Colors.blue);
                  return playerData.playerName == GameConstant.playerUknown 
                    ? _buildSignupButton(context) : Container();
                },
              ),
              /*_liveScoreService.playerNameNotifier.value == GameConstant.playerUknown 
                ? _buildSignupButton(context) : Container(),   */        
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSignupButton(BuildContext context) {
    LogUtil.debug('Building sign up button');
    return ElevatedButton(
      onPressed: () {
        //_gameServiceManager.startGame(game);   
        _gameStateManager.stateNotifier.value = StellarWarGameState.setting;       
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerSignup(playerAuthManager: _playerAuthManager),),
        );                          
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 24, color: Colors.white),
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
            Expanded(
              child: Text(
                '$value',
                style: TextStyle(
                  color: valueColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem<T>(String? label, dynamic value, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
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
  }

}