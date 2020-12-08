part of 'editAdsPage_bloc.dart';

abstract class EditAdsEvent extends Equatable {
  const EditAdsEvent();
}

class SubmitEditAds extends EditAdsEvent {
  final Ad newAd;
  final List imagesAwsRemove;
  const SubmitEditAds(this.newAd, this.imagesAwsRemove);

  @override
  List<Object> get props => [newAd, imagesAwsRemove];

  @override
  String toString() => 'SubmitEditAds';
}
