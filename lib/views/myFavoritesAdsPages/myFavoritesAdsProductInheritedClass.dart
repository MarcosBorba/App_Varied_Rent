import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';

class CacheProviderFavoriteAds extends InheritedWidget {
  final List<Ad> ads;
  final Widget child;
  CacheProviderFavoriteAds(
    this.ads,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProviderFavoriteAds of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CacheProviderFavoriteAds>();
  }

  @override
  bool updateShouldNotify(CacheProviderFavoriteAds old) => true;
}
