
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';

abstract class IGameState {

  // --- Game State Management ---
  ValueNotifier<StellarWarGameState> get stateNotifier;

  void changeState(StellarWarGameState newState);

}