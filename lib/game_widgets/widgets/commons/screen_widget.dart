
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/stellar_war_game.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/boost_player_speed_btn.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/down_control_btn.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/fire_bullet_control_btn.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/left_control_button.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/commons/level_up_overlay.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/commons/restart_button_overlay.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/commons/resume_pause_button_overlay.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/right_control_btn.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/commons/setting_button_overlay.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/commons/start_signup_button_overlay.dart';
import 'package:open_stellar_wars/game_widgets/widgets/game_controls/control_player/up_control_btn.dart';
import 'package:open_stellar_wars/game_widgets/widgets/scoreboards/live_score_board.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('EndlessRunnerGame().isFirstRun -> ${StellarWarGame().isFirstRun}');
    return Scaffold(
      body: Stack(
        children: [
          _buildGameWidget(),
        ],
      ),
    );
  }

  GameWidget _buildGameWidget() {
    return GameWidget(
            
            game: StellarWarGame(),
            overlayBuilderMap: {              
              'start': (context, game) => StartSignupButtonOverlay(game: game as StellarWarGame),
              'leftControlBtn': (context, game) => LeftControlButton(game: game as StellarWarGame),
              'rightControlBtn': (context, game) => RightControlBtn(game: game as StellarWarGame),
              'restart': (context, game) => RestartButtonOverlay(game: game as StellarWarGame),
              'setting': (context, game) => SettingButtonOverlay(game: game as StellarWarGame),
              'playPause': (context, game) => ResumePauseButtonOverlay(gameRef: game as StellarWarGame),
              'liveScoreBoard': (context, game) => LiveScoreBoard(),
              'levelUp': (context, game) => LevelUpOverlay(game: game as StellarWarGame),
              'fireBulletControlBtn': (context, game) => FireBulletControlBtn(game: game as StellarWarGame),
              'upControlBtn': (context, game) => UpControlBtn(game: game as StellarWarGame),
              'downControlBtn': (context, game) => DownControlBtn(game: game as StellarWarGame),
              //'playerJumpBtn':  (context, game) => PlayerJumpBtn(game: game as EndlessRunnerGame),
              'boostPlayerSpeed': (context, game) => BoostPlayerSpeedBtn(game: game as StellarWarGame),
              //'upwardBtn': (context, game) => UpwardControlButton(game: game as EndlessRunnerGame),
              
            },

            
            initialActiveOverlays: StellarWarGame().isFirstRun
              ? const ['start', 'setting',] 
              : const ['setting'],
          );
  }

}