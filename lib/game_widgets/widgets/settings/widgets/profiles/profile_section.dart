import 'dart:io';


import 'package:flutter/material.dart';
import 'package:open_stellar_wars/constants/game_constant.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';
import 'package:open_stellar_wars/core/services/auth/player_auth_impl.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier_impl.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/theme/stellar_wars_theme.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({super.key, required this.playerData});
  final PlayerData playerData;

  //late PlayerData playerData; 
  final IPlayerAuth _playerAuthManager = PlayerAuthImpl(); 
  final IPlayerDataNotifier _playerDataNotifierManager = PlayerDataNotifierImpl();
  

  @override
  Widget build(BuildContext context) {
    //LogUtil.debug('Loaded player-> player name: ${playerData.playerName}, level: ${playerData.level}, topScore: ${playerData.topScore}, dob: ${playerData.dateOfBirth}, img: ${playerData.profileImgPath}');    
    return _buildRow(context);
  }

  Row _buildRow(BuildContext context,) {
    LogUtil.debug('Start building Setting - Profile Section, profileImg ->');
    return Row(
      children: [
        _buildProfileImg(),
        const SizedBox(width: 20,),
        _buildPlayerName(), 
      ],
    );
  }

  Widget _buildProfileImg() {
    return ValueListenableBuilder<PlayerData>(
      valueListenable: _playerDataNotifierManager.playerDataNotifier, 
      builder: (context, pd, child) {
        //LogUtil.debug('Porifle -> ${pd.profileImgPath}');
        return 
          pd.playerName != GameConstant.playerUknown ?
          GestureDetector(
                onTap: () => _showPicDialog(context, pd.profileImgPath!),
                child: CircleAvatar( 
                          backgroundImage: FileImage(File(pd.profileImgPath!)),
                          radius: 40,
                        ))
          : const CircleAvatar(radius: 40, 
                        child: Icon(Icons.person, size: 40),);
        
      }
    );
  }

  Widget _buildPlayerName() {
    return ValueListenableBuilder<PlayerData>(
      valueListenable: _playerDataNotifierManager.playerDataNotifier, 
      builder: (context, playerData, child) {
        return playerData.playerName == GameConstant.playerUknown
        ? Text(
                playerData.playerName,              
                style: StellarWarsTheme.of(context).titleH2TextStyle,
              )
            : _buildEditProfileSignOut();
      }
    );
  }

  Column _buildEditProfileSignOut() {
    LogUtil.debug('Building Edit Profile and Sign Out buttons');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<PlayerData>(
          valueListenable: _playerDataNotifierManager.playerDataNotifier, 
          builder: (context, pd, child) {
            return Text(          
              pd.playerName,              
              style: StellarWarsTheme.of(context).titleH2TextStyle,
            );
          }
        ),
        
        Row(
          children: [         
            ValueListenableBuilder<PlayerData>(
              valueListenable: _playerDataNotifierManager.playerDataNotifier, 
              builder: (context, pd, child) {
                return TextButton(
                  onPressed: () {
                    // Open dialog to edit player name/image
                    showPlayerEditDialog(context, pd);
                  },
                  child: Text('Edit Profile', style: StellarWarsTheme.of(context).normalTextStyle,),
                );
              }
            ) ,
            
            const SizedBox(width: 10), // Spacing between buttons
            TextButton(
              onPressed: () {
                // Sign-out logic
                LogUtil.debug('Sign-out button tapped');
                //_signOut(context);
              },
              child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            ),                
          ],
        ),
      ],
    );
  }

  void _signOut(BuildContext context) {
    // Implement your sign-out logic here
    LogUtil.debug('Executing sign-out logic');
    showDialog(context: context, builder: (BuildContext context) => _alertDialog(context));
  }

  AlertDialog _alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Sign Out', style: StellarWarsTheme.of(context).titleH4TextStyle,),
      content: Text('Are you sure you want to sign out?', style: StellarWarsTheme.of(context).normalTextStyle,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: StellarWarsTheme.of(context).normalTextStyle,),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            LogUtil.debug('Executing sign-out logic');
            await _playerAuthManager.deletePlayerData();
          },
          child: Text('Sign Out', style: StellarWarsTheme.of(context).normalTextStyle,),
        ),
      ],
    );
  }

  Future<void> showPlayerEditDialog(BuildContext context, PlayerData playerData) async {
    try {
      /*
      final upd = await showDialog<PlayerData>(
        context: context,
        builder: (BuildContext context) {
          return PlayerSignedupEdit(playerData: playerData);
        }
      );      

      if (upd != null) {
        LogUtil.debug('Updated player after player clicked Update Info-> player name: ${upd.playerName}, level: ${upd.level}, topScore: ${upd.topScore}, dob: ${upd.dateOfBirth}, img: ${upd.profileImgPath}');
        playerData.playerName = upd.playerName;
        playerData.profileImgPath = upd.profileImgPath;
        playerData.dateOfBirth = upd.dateOfBirth;
        playerData.gender = upd.gender;
        playerData.profileImgPath = upd.profileImgPath;
        (context as Element).markNeedsBuild();
      }*/
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void _showPicDialog(BuildContext context, String imagePath) {
    LogUtil.debug('Try to initiate player profile dialog');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300, // Adjust the size of the enlarged image
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
  
}