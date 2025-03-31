import 'package:open_stellar_wars/core/services/player_healths/health_repair_damage.dart';
import 'package:open_stellar_wars/game_widgets/components/player_healths/health_repair_damages.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class HealthRepairDamageImpl implements IHealthRepairDamage {

  // Health repair damage
  final double _healthRepairSpawnInterval = 5.2;
  double _healthRepair = 0;
  final double _spawnSpeed = 80;  // Speed of health repair movement

  @override
  void collected() {
    // TODO: implement collected
  }

  @override
  void applyGravity(double dt, StellarWarGame gameRef, HealthRepairDamages healthRepair) {
    // TODO: implement applyGravity
  }

  @override
  void setHealthRepairSpawnBounds() {
    // TODO: implement setHealthRepairSpawnBounds
  }

  @override
  void spawnHealthRepairDamage(StellarWarGame gameRef, double dt) {
    // TODO: implement spawnHealthRepairDamage
  }

}