import 'dart:convert';


import 'package:flame/cache.dart';
import 'package:flutter/services.dart';
import 'package:open_stellar_wars/core/services/games/image_asset.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class ImageAssetImpl implements IImageAsset {

  final String _imgJson = 'assets/data/img_asset_names.json';
  static List<String>? _cachedImgAssetNames;

  @override
  Future<void> preLoadImgAssets(Images images) async {
    try {
      if (_cachedImgAssetNames == null) {
        final String response = await rootBundle.loadString(_imgJson);
        _cachedImgAssetNames = List<String>.from(jsonDecode(response)['imgAssetNames']);
      }
      
      // Load all images in parallel for better performance
      //await images.loadAll(_imgAssetNames);
      await Future.wait(_cachedImgAssetNames!.map((img) => images.load(img)));

      LogUtil.debug('Succesfully completed pre load image assets');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}