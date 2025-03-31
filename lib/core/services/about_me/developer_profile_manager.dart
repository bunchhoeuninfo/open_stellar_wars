


import 'package:open_stellar_wars/core/models/developer_profile.dart';

abstract class IDeveloperProfileManager {
  Future<DeveloperProfile> loadProfileJson();
}