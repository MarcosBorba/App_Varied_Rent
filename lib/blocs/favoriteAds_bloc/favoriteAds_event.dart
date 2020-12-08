part of 'favoriteAds_bloc.dart';

abstract class FavoriteAdsEvent extends Equatable {
  const FavoriteAdsEvent();
}

class FavoriteAdsPageStarted extends FavoriteAdsEvent {
  const FavoriteAdsPageStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'FavoriteAdsPageStarted => ok';
}

class FavoriteAdDeleteAd extends FavoriteAdsEvent {
  final String idAd;
  final List<Ad> ads;
  final int index;
  FavoriteAdDeleteAd(this.idAd, this.ads, this.index);

  @override
  List<Object> get props => [idAd, ads, index];

  @override
  String toString() => 'FavoriteAdDeleteAd => $idAd, $ads, $index';
}
