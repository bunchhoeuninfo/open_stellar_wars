
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_state.dart';
import 'package:open_stellar_wars/core/state/plasma_fighter_state.dart';

class PlasmaFighterStateImpl implements IPlasmaFighterState {

  // Singleton
  static final PlasmaFighterStateImpl _instance = PlasmaFighterStateImpl._internal();
  factory PlasmaFighterStateImpl() => _instance;
  PlasmaFighterStateImpl._internal();

  @override
  void changeState(PlasmaFighterState newState) {    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override  
  ValueNotifier<PlasmaFighterState>  stateNotifier = ValueNotifier<PlasmaFighterState>(PlasmaFighterState.idle);


}