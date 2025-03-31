import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/state/health_repair_damage_state.dart';

abstract class IHealthRepairDamageState {
  ValueNotifier<HealthRepairDamageState> get stateNotifier;
  void changeState(HealthRepairDamageState newState);
}