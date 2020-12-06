import 'package:flutter/material.dart';

class CacheProviderEditAd extends InheritedWidget {
  final UniqueKey keyImages;
  final List allImages;
  final Widget child;
  CacheProviderEditAd(
    this.keyImages,
    this.allImages,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProviderEditAd of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProviderEditAd>();
  }

  @override
  bool updateShouldNotify(CacheProviderEditAd old) => true;
}
