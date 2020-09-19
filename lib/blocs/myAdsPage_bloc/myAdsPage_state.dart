part of 'myAdsPage_bloc.dart';

class MyAdProductState extends Equatable {
  const MyAdProductState();

  @override
  List<Object> get props => [];
}

class ShowMyAdProduct extends MyAdProductState {
  final List<Ad> ads;

  const ShowMyAdProduct({@required this.ads});

  @override
  List<Object> get props => [ads];

  @override
  String toString() => 'ShowMyAdProduct { ads: $ads }';
}

class DeleteMyAdProductSuccess extends MyAdProductState {
  DeleteMyAdProductSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DeleteMyAdProduct';
}

class LoadingMyAdProduct extends MyAdProductState {}

class FailureMyAdProduct extends MyAdProductState {
  final String error;

  const FailureMyAdProduct({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureMyAdProduct { error: $error }';
}
