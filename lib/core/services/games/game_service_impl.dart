

import 'package:flame/components.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/plasma_fighters/plasma_fighter_impl.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter.dart';
import 'package:open_stellar_wars/core/services/enemies/swarm_fighters/swarm_fighter_impl.dart';
import 'package:open_stellar_wars/core/services/games/game_service.dart';
import 'package:open_stellar_wars/core/services/games/game_state.dart';
import 'package:open_stellar_wars/core/services/games/game_state_impl.dart';
import 'package:open_stellar_wars/core/state/stellar_war_game_state.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/components/backgrounds/dark_space_background.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';



class GameServiceImpl implements IGameService {
  //final GameServiceManager _gameServiceManager = GameServiceService();
  final IGameState _gameStateManager = GameStateImpl();
  final ISwarmFighter _swarmFighter = SwarmFighterImpl();
  final IPlasmaFighter _plasmaFighter = PlasmaFighterImpl();

  @override
  void setupBackground(StellarWarGame game) {
    double screenHeight = game.size.y;
    try {
      //game.add(DarkSpaceBackground(position: Vector2(0, -screenHeight), speed: 50 ));
      //game.add(DarkSpaceBackground(position: Vector2(0, 0), speed: 50));      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }   
  }
  
  @override
  void gameOver(StellarWarGame game) {
    //if (game.gameStateManager.isPlaying()) {
    if (_gameStateManager.stateNotifier.value == StellarWarGameState.playing) {
      try {
        LogUtil.debug('Game Over.');
        _gameStateManager.stateNotifier.value = StellarWarGameState.gameOver;
        game.overlays.add('restart');
        game.pauseEngine();
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void restartGame(StellarWarGame game) {    
    if (_gameStateManager.stateNotifier.value == StellarWarGameState.gameOver) {
      try {
        LogUtil.debug('Try to restartGame...');
      
        game.resumeEngine();  //Resume the game loop   
        _gameStateManager.stateNotifier.value = StellarWarGameState.playing;        
        game.isFirstRun = false;        
        game.overlays.remove('restart');
        game.overlays.add('liveScoreBoard');
        
        // Reset background
        setupBackground(game);
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void startGame(StellarWarGame game) {
    //LogUtil.debug('Game state -> isMenu: ${game.gameStateManager.isMenu()}, isGameOver: ${game.gameStateManager.isGameOver()}, isPause: ${game.gameStateManager.isPaused()}');
    try {
      LogUtil.debug('Try to start game.');
      List<String> overlayTexts = ['start', 'levelUp', 'restart', 'gameOver'];
      game.overlays.removeAll(overlayTexts);
      game.overlays.add('liveScoreBoard');
      game.isFirstRun = false;
      game.resumeEngine();      
      _gameStateManager.stateNotifier.value = StellarWarGameState.playing;
      LogUtil.debug('Game Started!');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }
  
  @override
  void addEntities(StellarWarGame game) {    
    try {
      LogUtil.debug('Try to add overlay control to the game world.');  
      List<String> overlayBtns = ['start', 'setting', 'playPause','leftControlBtn','rightControlBtn','boostPlayerSpeed', 
        'fireBulletControlBtn', 'upControlBtn', 'downControlBtn'];
    
      // Overlay ojects
      game.overlays.addAll(overlayBtns);

      game.add(DarkSpaceBackground(speed: 50));
      // Add collision detection
      game.add(ScreenHitbox());
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  void pauseGame(StellarWarGame game) {    
    try {
      LogUtil.debug('Try to pause game');
      game.pauseEngine();
      LogUtil.debug('Game Paused!');    
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }
  
  @override
  void resumeGame(StellarWarGame game) {
    if (_gameStateManager.stateNotifier.value == StellarWarGameState.resumed) {
      try {
        LogUtil.debug('Try to resume game');
        _gameStateManager.stateNotifier.value = StellarWarGameState.playing;
        game.resumeEngine();
        LogUtil.debug('Game Resumed!');    
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }
  }
  
  @override
  void levelUp(StellarWarGame game) {
    try {
      LogUtil.debug('Level Up!');
      _gameStateManager.stateNotifier.value = StellarWarGameState.menu;
      game.overlays.add('levelUp');
      game.pauseEngine();
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void onGameStateChanged(double dt, StellarWarGameState state, StellarWarGame game) {
    //LogUtil.debug('Game method gameStateManager.stateNotifier.value -> ${_gameStateManager.stateNotifier.value}');
    try {
      if (state == StellarWarGameState.playing) {
        _swarmFighter.spawnSwarmFighterEnemies(game, dt);
        _plasmaFighter.spawnPlasmaFighterEnemies(game, dt);

      } 
      else if (state == StellarWarGameState.paused) {
        LogUtil.debug('Game method gameStateManager.isPaused() -> $state');
        pauseGame(game);
      } else if (state == StellarWarGameState.resumed) {
        LogUtil.debug('Game method gameStateManager.isResumed() -> $state');
        resumeGame(game);
      } 
      else if (state == StellarWarGameState.menu) {
        game.pauseEngine();
        LogUtil.debug('Game method gameStateManager.isMenu() -> $state');
      } else if (state == StellarWarGameState.setting) {
        LogUtil.debug('Try to pause the game engine when player goto setting section');
        pauseGame(game);
      } else if (state == StellarWarGameState.start) {
        pauseGame(game);
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }
  
  @override
  void setupDynamicBackground(StellarWarGame game) {
    try {
      LogUtil.debug('Try to setup dynamic background');
     // final gbg = GridBackground();
     // game.add(gbg);

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  


}