part of 'adProduct_bloc.dart';

abstract class AdProductPageEvent extends Equatable {
  const AdProductPageEvent();
}

class AdProductPageGetInfoAd extends AdProductPageEvent {
  final String idAd;
  final String locatorFk;
  const AdProductPageGetInfoAd(this.idAd, this.locatorFk);

  @override
  List<Object> get props => [idAd, locatorFk];

  @override
  String toString() => 'AdProductPageGetInfoAd => $idAd, $locatorFk';
}
