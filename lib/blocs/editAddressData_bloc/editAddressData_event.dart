part of 'editAddressData_bloc.dart';

abstract class EditMyAddressEvent extends Equatable {
  const EditMyAddressEvent();
}

class SaveAddressDataButtonPressed extends EditMyAddressEvent {
  final User user;
  const SaveAddressDataButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SaveAddressDataButtonPressed { user: $user } ';
}

class PageEditMyAddressStarted extends EditMyAddressEvent {
  const PageEditMyAddressStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PageEditMyAddressStarted => ok';
}
