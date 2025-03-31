
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';
import 'package:open_stellar_wars/core/services/players/player_data_notifier.dart';

class PlayerDataNotifierImpl implements IPlayerDataNotifier {

  // Singleton
  static final PlayerDataNotifierImpl _instance = PlayerDataNotifierImpl._internal();
  factory PlayerDataNotifierImpl() => _instance;
  PlayerDataNotifierImpl._internal();

  @override
  // TODO: implement playerDataNotifier
  ValueNotifier<PlayerData> playerDataNotifier = ValueNotifier<PlayerData>(PlayerData(playerName: 'Unknown', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(DateTime.now().toIso8601String().split('T').first), profileImgPath: null, settings: null)  );

}