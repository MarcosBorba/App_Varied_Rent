part of 'insertAdsPage_bloc.dart';

class InsertAdsState extends Equatable {
  const InsertAdsState();

  @override
  List<Object> get props => [];
}

class SuccessOnSubmit extends InsertAdsState {}

class InitInsertAdsPage extends InsertAdsState {}

class InsertAdsLoadingPage extends InsertAdsState {}

class InsertAdsFailurePage extends InsertAdsState {
  final String error;

  const InsertAdsFailurePage({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'InsertAdsFailurePage { error: $error }';
}
