part of 'editAdsPage_bloc.dart';

class EditAdsState extends Equatable {
  const EditAdsState();

  @override
  List<Object> get props => [];
}

class SuccessOnEditSubmit extends EditAdsState {}

class InitEditAdsPage extends EditAdsState {}

class EditAdsLoadingPage extends EditAdsState {}

class EditAdsFailurePage extends EditAdsState {
  final String error;

  const EditAdsFailurePage({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EditAdsFailurePage { error: $error }';
}
