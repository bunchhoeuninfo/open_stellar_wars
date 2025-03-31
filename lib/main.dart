import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';
import 'package:open_stellar_wars/game_widgets/widgets/commons/game_main.dart';
import 'package:open_stellar_wars/game_widgets/widgets/commons/no_internet_widget.dart';

void main() {
  Widget appWidget;
  try {
    LogUtil.debug('Try to initialize main app');
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Enables full-screen mode
    //setDeviceOrientation();
    appWidget = const GameMain();
    LogUtil.info("Succesfully initialized game app...");
    
  } catch (e) {
    appWidget = MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: NoInternetWidget(
        onRetry: () {
          main(); // Retry on error
        },
      ),
    );

    LogUtil.error('Exception -> $e');
  }

  runApp(appWidget);
}

void setDeviceOrientation() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]
  );
}
