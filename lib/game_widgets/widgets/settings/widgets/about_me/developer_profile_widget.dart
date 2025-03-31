
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:open_stellar_wars/core/models/developer_profile.dart';
import 'package:open_stellar_wars/core/services/about_me/developer_profile_manager.dart';
import 'package:open_stellar_wars/core/services/about_me/developer_profile_service.dart';
import 'package:open_stellar_wars/game_widgets/widgets/settings/widgets/about_me/developer_profile_card.dart';


class DeveloperProfileWidget extends StatelessWidget {
  DeveloperProfileWidget({super.key});

  final Logger _logger = Logger();
  final String _className = 'DeveloperProfileWidget';
  final IDeveloperProfileManager _developerProfileManager = DeveloperProfileServiceImpl();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) _logger.d('Start $_className.build method ...');

    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () {             
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: _buildDevProfile(context)
    );*/
    return _buildDevProfile(context);
  }

  Widget _buildDevProfile(BuildContext context) {
    if (kDebugMode) _logger.d('Start $_className.build _buildDevProfile ...');
    try {
      return FutureBuilder<DeveloperProfile>(
      future: _developerProfileManager.loadProfileJson(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading profile'));
        } else if (snapshot.hasData) {          
          return DeveloperProfileCard(devProfile: snapshot.data!,);
        } else {
          return const Center(child: Text('No profile data found'));
          }
        },
      );
    } catch (e) {
      _logger.e('Exception -> $e');
      return const Center(child: CircularProgressIndicator(),);
    } 
  }

}