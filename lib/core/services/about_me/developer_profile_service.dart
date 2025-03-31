import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:open_stellar_wars/core/models/developer_profile.dart';
import 'package:open_stellar_wars/core/services/about_me/developer_profile_manager.dart';

class DeveloperProfileServiceImpl implements IDeveloperProfileManager {

  final Logger _logger = Logger();
  final String _className = 'DeveloperProfilerService';
  final String _devProfileJson = 'assets/data/developer_profile.json';

  @override
  Future<DeveloperProfile> loadProfileJson() async {
    if (kDebugMode) _logger.d('Start inside $_className.loadProfileJson ...');

    try {
      final String jsonString = await rootBundle.loadString(_devProfileJson);
      final Map<String, dynamic> jsonData = json.decode(jsonString);      
      return DeveloperProfile.fromMap(jsonData);
    } catch (e) {
      _logger.d('Exception -> $e');
      return DeveloperProfile(name: 'name', title: 'title', expertise: 'expertise', bio: 'bio', imageUrl: 'imageUrl', email:'bunchhoeun.chhim@gmail.com');
    }    
  }
}