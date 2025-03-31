

import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/models/player_data.dart';

abstract class IPlayerDataNotifier {
  ValueNotifier<PlayerData> get playerDataNotifier;
}