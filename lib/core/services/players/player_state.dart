
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/state/player_state.dart';

abstract class IPlayerState {
  // --- Player State Management ---
  ValueNotifier<PlayerState> get stateNotifier;

  void changeState(PlayerState newState);
}