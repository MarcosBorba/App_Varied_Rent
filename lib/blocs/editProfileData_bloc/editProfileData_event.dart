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
  /* 'SaveProfileDataButtonPressed { name: ' +
      user.name +
      ', genre: ' +
      user.genre +
      ', landLordType: ' +
      user.landlord_type +
      ', cpfCnpj: ' +
      user.cpf_cnpj +
      ', phones: telephone1 - ' +
      user.phones.telephone1 +
      ', telephone2 - ' +
      user.phones.telephone2 +
      ', token: ' +
      user.token +
      ' }'; */
}

class PageEditMyProfileStarted extends EditMyProfileEvent {
  const PageEditMyProfileStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PageEditMyProfileStarted => ok';
}
