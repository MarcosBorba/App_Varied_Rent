part of 'favoriteAds_bloc.dart';

class FavoriteAdsState extends Equatable {
  const FavoriteAdsState();

  @override
  List<Object> get props => [];
}

class ShowFavoriteAdsPage extends FavoriteAdsState {
  final List<Ad> ads;

  const ShowFavoriteAdsPage({@required this.ads});

  @override
  List<Object> get props => [ads];

  @override
  String toString() => 'ShowFavoriteAdsPage { ads: $ads }';
}

class DeleteMyFavoriteAdSuccess extends FavoriteAdsState {
  DeleteMyFavoriteAdSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DeleteMyFavoriteAdSuccess';
}

class FavoriteAdsLoading extends FavoriteAdsState {}

class FavoriteAdsFailure extends FavoriteAdsState {
  final String error;

  const FavoriteAdsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FavoriteAdsFailure { error: $error }';
}
