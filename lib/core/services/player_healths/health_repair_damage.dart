
import 'package:open_stellar_wars/game_widgets/components/player_healths/health_repair_damages.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IHealthRepairDamage {
  void collected();
  void setHealthRepairSpawnBounds();
  void spawnHealthRepairDamage(StellarWarGame gameRef, double dt);
  void applyGravity(double dt, StellarWarGame gameRef, HealthRepairDamages healthRepair);
}