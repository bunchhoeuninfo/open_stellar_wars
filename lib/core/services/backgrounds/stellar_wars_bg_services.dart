
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:logger/logger.dart';

import 'package:open_stellar_wars/core/services/backgrounds/stellar_wars_bg_manager.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/core/utils/screen_utils.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';


class StellarWarsBgServicesImpl implements IStellarWarsBgManager  {
  @override
  Future<ParallaxComponent<FlameGame<World>>> getParallaxBg(StellarWarGame gameRef, double speed) async {
    try {
      final parallax = await gameRef.loadParallax(
        [
          ParallaxImageData('backgrounds/dark_space.png'),
          //ParallaxImageData('backgrounds/dark_space.png'),        
        ],
            // Scale the image
        baseVelocity: Vector2(0, -speed),  // Moves downward (simulate player running upward)
        repeat: ImageRepeat.repeatY,    // Repeat the image in the Y-axis
        //fill: LayerFill.none,          // Fill the layer with the width of the screen
        
      );

      return ParallaxComponent(parallax: parallax, size: ScreenUtils.getScreenSize(),);

    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading parallax background');
    }
  }


}