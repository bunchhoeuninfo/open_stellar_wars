import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/state/swarm_fighter_state.dart';

abstract class ISwarmFighterState {
  ValueNotifier<SwarmFighterState> get stateNotifier;
  void changeState(SwarmFighterState newState);
}