import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';

class CacheProviderAds extends InheritedWidget {
  final List<Ad> ads;
  final Widget child;
  CacheProviderAds(
    this.ads,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProviderAds of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProviderAds>();
  }

  @override
  bool updateShouldNotify(CacheProviderAds old) => true;
}
