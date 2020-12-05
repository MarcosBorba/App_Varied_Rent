part of 'insertAdsPage_bloc.dart';

abstract class InsertAdsEvent extends Equatable {
  const InsertAdsEvent();
}

class SubmitNewAds extends InsertAdsEvent {
  final Ad newAd;
  const SubmitNewAds(this.newAd);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SubmitNewAds';
}
