import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';

class CacheProviderInsertAd extends InheritedWidget {
  final List<Asset> imagesSelected;
  final List<ImageFile> imagesFile;
  final SwiperController swiperController;
  final UniqueKey keyImages;
  final Widget child;
  CacheProviderInsertAd(
    this.imagesSelected,
    this.imagesFile,
    this.swiperController,
    this.keyImages,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProviderInsertAd of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProviderInsertAd>();
  }

  @override
  bool updateShouldNotify(CacheProviderInsertAd old) => true;
}
