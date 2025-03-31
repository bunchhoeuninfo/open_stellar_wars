import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/screen_utils.dart';

import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';

class DarkSpaceBackground extends Component with HasGameRef<StellarWarGame>{

  DarkSpaceBackground({required this.speed});

  final double speed;
  late SpriteComponent bg1;
  late SpriteComponent bg2;

  final IGameState _gameStateManager = GameStateImpl();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenSize = ScreenUtils.getScreenSize();
    final bgImage = await gameRef.loadSprite('backgrounds/dark_space.png');

    // First background image (top position)
    bg1 = SpriteComponent(
      sprite: bgImage,
      size: screenSize,
      position: Vector2(0, 0), // Starts at the top
    );

    // Second background image (below the first one)
    bg2 = SpriteComponent(
      sprite: bgImage,
      size: screenSize,
      position: Vector2(0, -screenSize.y), // Placed right above bg1
    );

    addAll([bg1, bg2]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    applyGravity(dt);
    
  }

  void applyGravity(double dt) {

    final gameState = _gameStateManager.stateNotifier.value;

    if (gameState == StellarWarGameState.playing) {
      // Move both backgrounds downward
      bg1.position.y += speed * dt;
      bg2.position.y += speed * dt;

      final screenHeight = ScreenUtils.getScreenSize().y;

      // Reset position when an image moves out of view
      if (bg1.position.y >= screenHeight) {
        bg1.position.y = bg2.position.y - screenHeight;
      }
      if (bg2.position.y >= screenHeight) {
        bg2.position.y = bg1.position.y - screenHeight;
      }
    }
    
  }

}