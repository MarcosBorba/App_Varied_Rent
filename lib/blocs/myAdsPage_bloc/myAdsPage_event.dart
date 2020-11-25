part of 'myAdsPage_bloc.dart';

abstract class MyAdsPageEvent extends Equatable {
  const MyAdsPageEvent();
}

class MyAdsPageStarted extends MyAdsPageEvent {
  const MyAdsPageStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'MyAdsPageStarted => ok';
}

class MyAdsPageAddAds extends MyAdsPageEvent {
  final String image;
  MyAdsPageAddAds(this.image);

  @override
  List<Object> get props => [image];

  @override
  String toString() => 'MyAdsPageAddAds => ok';
}

class MyAdsPageDeleteAd extends MyAdsPageEvent {
  final String id;
  final List<Ad> ads;
  final int index;
  MyAdsPageDeleteAd(this.id, this.ads, this.index);

  @override
  List<Object> get props => [id, ads, index];

  @override
  String toString() => 'MyAdsPageDeleteAd => $id, $ads, $index';
}
