
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/game_widgets/widgets/commons/screen_widget.dart';

class GameMain extends StatelessWidget {
  const GameMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenWidget(),
    );
  }
}