
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_state.dart';
import 'package:open_stellar_wars/core/state/swarm_fighter_state.dart';

class SwarmFighterStateImpl implements ISwarmFighterState {

  static final SwarmFighterStateImpl _instance = SwarmFighterStateImpl._internal();
  factory SwarmFighterStateImpl() => _instance;
  SwarmFighterStateImpl._internal();

  @override
  void changeState(SwarmFighterState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  ValueNotifier<SwarmFighterState> stateNotifier = ValueNotifier(SwarmFighterState.idle);

}