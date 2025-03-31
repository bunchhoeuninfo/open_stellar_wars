

import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/menu_settings/menu_section.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/profiles/profile_section.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key, required this.gameRef});

  final StellarWarGame gameRef;
  final IGameService _gameServiceManager = GameServiceImpl();
  final IPlayerAuth _playerAuthManager = PlayerAuthImpl();
  final IGameState _gameStateManager = GameStateImpl();
  final IPlayerDataNotifier _dataNotifierManager = PlayerDataNotifierImpl();


  @override
  Widget build(BuildContext context) {

    LogUtil.debug('Initiate game setting');
    //gameRef.gameStateManager.setState(GameState.menu);
    //_gameStateManager.stateNotifier.value = GameState.menu;
    _gameStateManager.changeState(StellarWarGameState.menu);
    LogUtil.debug('Game state changed to _gameStateManager.stateNotifier.value: ${_gameStateManager.stateNotifier.value}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () { 
            // Resume game
            LogUtil.debug('Game state -> ${_gameStateManager.stateNotifier.value}');
            _gameStateManager.stateNotifier.value == StellarWarGameState.paused 
              ? _gameServiceManager.resumeGame(gameRef)
              : //gameRef.gameStateManager.setState(GameState.menu);
                //_gameStateManager.stateNotifier.value = GameState.menu;
                _gameStateManager.changeState(StellarWarGameState.menu);
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: _futureLoadPlayer(),
    );
  }

  FutureBuilder _futureLoadPlayer() {
    LogUtil.debug('Inside future build method');
    try {
      return FutureBuilder(
        future: _playerAuthManager.loadPlayerData(), 
        builder: (context, snapshot) {
          //final pd = snapshot.data as PlayerData;
          //LogUtil.debug('Iterating player data -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          } else if(snapshot.hasData && snapshot.data is PlayerData) {
            final pd = snapshot.data as PlayerData;
            LogUtil.debug('Iterating player data -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
            return _buildScrollableContent(pd,);                        
          } else {
            return const Center(child: Text('Invalid data'),);
          }
        }
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return const Center(child: Text('Exception'),);
      });
    }
    
  }

  Widget _buildScrollableContent(PlayerData playerData) {
    LogUtil.debug('Start building Setting.');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(playerData: playerData),
            const SizedBox(height: 40),
            
            MenuSection(playerData: playerData,),
            const SizedBox(height: 40),
            //const SignInButton(isSignedIn: false),            
          ],
        ),
      ),
    );
  }
  
}