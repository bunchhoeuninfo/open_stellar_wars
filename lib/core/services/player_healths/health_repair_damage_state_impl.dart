
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage_state.dart';
import 'package:open_stellar_wars/core/state/health_repair_damage_state.dart';

class HealthRepairDamageStateImpl implements IHealthRepairDamageState {

  
 static final HealthRepairDamageStateImpl _instance = HealthRepairDamageStateImpl._internal();
  factory HealthRepairDamageStateImpl() => _instance;
  HealthRepairDamageStateImpl._internal();

  @override
  void changeState(HealthRepairDamageState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  ValueNotifier<HealthRepairDamageState> stateNotifier = ValueNotifier(HealthRepairDamageState.idle);


}