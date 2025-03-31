import 'package:flame/cache.dart';

abstract class IImageAsset {
  Future<void> preLoadImgAssets(Images images);
}