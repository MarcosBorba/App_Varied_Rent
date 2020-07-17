part of "./editProfileData_bloc.dart";

abstract class EditMyProfileEvent extends Equatable {
  const EditMyProfileEvent();
}

class SaveProfileDataButtonPressed extends EditMyProfileEvent {
  final User user;
  const SaveProfileDataButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SaveProfileDataButtonPressed { user: $user } ';
}

class PageEditMyProfileStarted extends EditMyProfileEvent {
  const PageEditMyProfileStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PageEditMyProfileStarted => ok';
}
