import 'package:flutter/material.dart';

class CacheProviderEditAd extends InheritedWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final Widget child;
  CacheProviderEditAd(
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
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
