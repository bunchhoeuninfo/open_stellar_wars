import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/state/plasma_fighter_state.dart';

abstract class IPlasmaFighterState {

  // -- Plasma frigate state manager --
  ValueNotifier<PlasmaFighterState> get stateNotifier;

  void changeState(PlasmaFighterState newState);

}