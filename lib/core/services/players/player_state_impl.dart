
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/players/player_state.dart';
import 'package:open_stellar_wars/core/state/player_state.dart';

class PlayerStateImpl implements IPlayerState {

  // Singleton
  static final PlayerStateImpl _instance = PlayerStateImpl._internal();
  factory PlayerStateImpl() => _instance;
  PlayerStateImpl._internal();

  @override
  void changeState(PlayerState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<PlayerState> stateNotifier = ValueNotifier<PlayerState>(PlayerState.idle);

}