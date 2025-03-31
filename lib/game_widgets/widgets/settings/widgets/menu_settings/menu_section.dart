
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:open_stellar_wars/constants/game_constant.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_manager.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier_impl.dart';
import 'package:open_stellar_wars/core/services/scores/live_score_service.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/theme/stellar_wars_theme.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/about_me/developer_profile_widget.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/menu_settings/game_theme_setting.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/menu_settings/player_appearance_setting.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/menu_settings/sound_effect_setting.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/signup/player_signup.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key, required this.playerData});

  final PlayerData playerData;

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {

  late PlayerData _playerData;
  final IPlayerAuth _playerAuthManager = PlayerAuthImpl();
  final IPlayerDataNotifier _playerDataNotifierManager = PlayerDataNotifierImpl();
  final ILiveScoreManager _liveScoreManager = LiveScoreServiceImpl();

  @override
  void initState() {
    super.initState();
    _playerData = widget.playerData;
 }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Building menu seciton');

   return ValueListenableBuilder(valueListenable: _playerDataNotifierManager.playerDataNotifier,
      builder: (context, pd, child) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildMenuItems(context, pd),
      );
    },);
    
    
    
        //return _buildMenuItems(context);
  }

  List<Widget> _buildMenuItems(BuildContext context, PlayerData pd) {
    LogUtil.debug('Building menu item');
    
    return pd.playerName == GameConstant.playerUknown ? _unknownPlayerMenu(context) : _signedPlayerMenu(context);       
  }

  List<Widget> _signedPlayerMenu(BuildContext context) {
    return [
      _menuItem(
        context,
        icon: Icons.restore,
        text: 'Reset Game',
        subtitle: 'Reset Game Progress',
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: () {
          LogUtil.debug('Reset Game');
          showDialog(
            context: context,
            builder: (BuildContext context) => _resetGameDialog(context),
          );
        },
      ),
      _menuItem(
        context,
        icon: Icons.color_lens,
        text: 'Player Skin',
        trailing: PlayerAppearanceSetting(
          currentSkin: _playerData.settings['playerAppearance'][GameConstant.playerSkinKey] ??
              GameConstant.playerSkinClassic,
          onAppearanceChanged: (appearance) {
            LogUtil.debug('Player Skin Changed -> $appearance');
            setState(() {
              _playerData.settings['playerAppearance'] = {GameConstant.playerSkinKey: appearance};
            });
            _playerAuthManager.updatePlayerData(_playerData);
          },
        ),
        subtitle: _playerData.settings['playerAppearance'][GameConstant.playerSkinKey],
      ),
      _menuItem(
        context,
        icon: Icons.style,
        text: 'Game Theme',
        trailing: GameThemeSetting(
          currentTheme: _playerData.settings['gameTheme'][GameConstant.gameThemeKey] ??
              GameConstant.gameThemeLight,
          onThemeChanged: (gameTheme) {
            setState(() {
              _playerData.settings['gameTheme'] = {GameConstant.gameThemeKey: gameTheme};
            });
            _playerAuthManager.updatePlayerData(_playerData);
          },
        ),
        subtitle: _playerData.settings['gameTheme'][GameConstant.gameThemeKey] ??
            GameConstant.gameThemeLight,
      ),
      _menuItem(
        context,
        icon: Icons.volume_up,
        text: 'Sound Effects',
        subtitle: 'Sound Effects Settings',
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: () => _navigateTo(
          context,
          SoundEffectSetting(
            currentSoundEffectSettings: _playerData.settings[GameConstant.soundEffectsKey],
            onSettingsChanged: (soundEffectOption) {
              LogUtil.debug('Sound Effect Option -> $soundEffectOption');
              setState(() {
                _playerData.settings[GameConstant.soundEffectsKey] = soundEffectOption;
              });
              _playerAuthManager.updatePlayerData(_playerData);
            },
          ),
        ),
      ),
      _menuItem(
        context,
        icon: Icons.person,
        text: 'About Me',
        subtitle: 'Developer Profile',
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: () => _navigateTo(context, DeveloperProfileWidget()),
      ),
      _menuItem(
        context,
        icon: Icons.close,
        text: 'Quite',
        subtitle: 'Quite game',
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: () {
          _quitApp();
        },
      ),
    ];
  }

  List<Widget> _unknownPlayerMenu(BuildContext context) {
    return [
      _menuItem(
        context,
        icon: Icons.person_add,
        text: 'Sign Up',
        subtitle: 'Register now and enjoy the benefits',
        onTap: () => _navigateTo(
          context,
          PlayerSignup(playerAuthManager: _playerAuthManager),
        ),
      ),
      _menuItem(
        context,
        icon: Icons.arrow_back_sharp,
        text: 'Return to Game',
        subtitle: 'Continue your adventure',
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      _menuItem(
        context,
        icon: Icons.close,
        text: 'Quite',
        subtitle: 'Quite game',
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: () {
          _quitApp();
        },
      ),
    ];
  }

  Widget _menuItem(BuildContext context,
      {required IconData icon,
      required String text,
      Widget? trailing,
      VoidCallback? onTap, 
      String? subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 28),
      title: Text(text, style: StellarWarsTheme.of(context).menuTitleH4TextStyle),
      subtitle: subtitle != null ? Text(subtitle, style: StellarWarsTheme.of(context).menuSubTitleTextStyle,) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  void _quitApp() {
    exit(0); // Exits the app with a success code.
  }

  AlertDialog _resetGameDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Reset Game Progress', style: StellarWarsTheme.of(context).titleH4TextStyle,),
      content: Text('Are you sure you want to reset game progress?', style: StellarWarsTheme.of(context).normalTextStyle,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            //Navigator.pushReplacementNamed(context, 'routeName')
          },
          child: Text('Cancel', style: StellarWarsTheme.of(context).normalTextStyle,),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            LogUtil.debug('Executing reset game logic');
            _playerData.level = 1;
            _playerData.topScore = 0;
            _liveScoreManager.levelNotifier.value = 1;
            _liveScoreManager.scoreNotifier.value = 0;
            _liveScoreManager.highScoreNotifier.value = 0;
            await _playerAuthManager.updatePlayerData(_playerData);
          },
          child: Text('Confirm', style: StellarWarsTheme.of(context).normalTextStyle,),
        ),
      ],
    );
  }
  
}