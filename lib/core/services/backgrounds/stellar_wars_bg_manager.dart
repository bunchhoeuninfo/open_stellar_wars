import 'package:flame/components.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

abstract class IStellarWarsBgManager {
  Future<ParallaxComponent> getParallaxBg(StellarWarGame gameRef , double speed);
}