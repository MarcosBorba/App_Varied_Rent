import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CacheProviderInsertAd extends InheritedWidget {
  final List<Asset> imagesSelected;
  final List<File> imagesFile;
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
