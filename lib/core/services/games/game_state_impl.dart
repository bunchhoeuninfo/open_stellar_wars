
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';

class GameStateImpl implements IGameState {

  // Singleton
  static final GameStateImpl _instance = GameStateImpl._internal();
  factory GameStateImpl() => _instance;
  GameStateImpl._internal();

  @override
  // TODO: implement stateNotifier
  ValueNotifier<StellarWarGameState> stateNotifier = ValueNotifier<StellarWarGameState>(StellarWarGameState.start);
  
  @override
  void changeState(StellarWarGameState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    stateNotifier.value = newState;
  });
  }

}