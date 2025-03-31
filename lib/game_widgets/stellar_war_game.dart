import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:open_stellar_wars/core/services/backgrounds/stellar_wars_bg_manager.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/image_asset.dart';
import 'package:open_stellar_wars/core/services/backgrounds/stellar_wars_bg_services.dart';
import 'package:open_stellar_wars/core/services/games/game_service_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/services/games/image_asset_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/players/player.dart';

class StellarWarGame extends FlameGame with HasCollisionDetection, TapDetector {

  // State management
  final IGameState _gameState = GameStateImpl();

  //Image assets
  final IImageAsset _imageAsset = ImageAssetImpl();

  // check if the game is first run or restarted
  bool isFirstRun = true;

  //Player
  late Player player;

  // Game service
  final IGameService _gameService = GameServiceImpl();     

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    try {
      LogUtil.debug('Try to initialize StellarWarGame');

      // Load the game assets
      //player = Player(position: Vector2(size.x / 2, size.y / 2));
      player = Player(position: Vector2(size.x / 2, size.y / 0.25));

       // pre-load image assets to optimize the performance
      await _imageAsset.preLoadImgAssets(images);      
      
      _gameService.addEntities(this);
      addPlayer();                 

    } catch (e) {
      LogUtil.error('Excepiotn -> $e');
    }
  }


  void addPlayer() {
    _gameState.stateNotifier.addListener(() {
      if (_gameState.stateNotifier.value == StellarWarGameState.playing) {
        if (!children.contains(player)) {
          add(player);
          LogUtil.debug('Player added to the game world.');
        }
      } 
    });

    // If the game is already in playing state, add the player immediately
    if (_gameState.stateNotifier.value == StellarWarGameState.playing) {
      add(player);
    } 
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final state = _gameState.stateNotifier.value;
    _gameService.onGameStateChanged(dt, state, this);
  }

}