part of "./editProfileData_bloc.dart";

abstract class EditMyProfileState extends Equatable {
  const EditMyProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitialData extends EditMyProfileState {
  final String token;
  final String name;
  final String genre;
  final String landlordType;
  final String cpfCnpj;
  final Phones phones;

  EditProfileInitialData(
      {@required this.genre,
      @required this.landlordType,
      @required this.cpfCnpj,
      @required this.phones,
      @required this.token,
      @required this.name});

  List<Object> get props => [
        token,
        name,
        genre,
        landlordType,
        cpfCnpj,
        phones,
      ];

  String toString() =>
      'EditProfileInitialData { token: $token , name: $name, genre: $genre, landLordType: $landlordType, cpfCnpj: $cpfCnpj, phones: ' +
      phones.toString();
}

class DataProfileSuccessfullyEdited extends EditMyProfileState {
  final String token;
  final String name;
  final String genre;
  final String landlordType;
  final String cpfCnpj;
  final Phones phones;

  DataProfileSuccessfullyEdited(
      {@required this.genre,
      @required this.landlordType,
      @required this.cpfCnpj,
      @required this.phones,
      @required this.token,
      @required this.name});

  List<Object> get props => [
        token,
        name,
        genre,
        landlordType,
        cpfCnpj,
        phones,
      ];

  String toString() =>
      'DataProfileSuccessfullyEdited { token: $token , name: $name, genre: $genre, landLordType: $landlordType, cpfCnpj: $cpfCnpj, phones: ' +
      phones.toString();
}

class LoadingProfileDataEditing extends EditMyProfileState {}

class FailureProfileDataEditing extends EditMyProfileState {
  final String error;

  const FailureProfileDataEditing({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureDataEditing { error: $error }';
}
