part of "./editProfileData_bloc.dart";

abstract class EditMyProfileState extends Equatable {
  const EditMyProfileState();

  @override
  List<Object> get props => [];
}

abstract class GetDatasDefault extends EditMyProfileState {
  final String token;
  final String name;
  final String genre;
  final String landlordType;
  final String cpfCnpj;
  final Phones phones;

  const GetDatasDefault(
      {@required this.genre,
      @required this.landlordType,
      @required this.cpfCnpj,
      @required this.phones,
      @required this.token,
      @required this.name});

  @override
  List<Object> get props => [
        token,
        name,
        genre,
        landlordType,
        cpfCnpj,
        phones,
      ];

  @override
  String toString() =>
      'GetDatasDefault { token: $token , name: $name, genre: $genre, landLordType: $landlordType, cpfCnpj: $cpfCnpj, phones: ' +
      phones.toString();
}

class EditProfileInitialData extends GetDatasDefault {
  EditProfileInitialData(name, genre, landlordType, cpfCnpj, phones, token)
      : super(
            name: name,
            genre: genre,
            landlordType: landlordType,
            cpfCnpj: cpfCnpj,
            phones: phones,
            token: token);

  @override
  List<Object> get props => super.props;

  @override
  String toString() => super.toString();
}

class DataProfileSuccessfullyEdited extends GetDatasDefault {
  DataProfileSuccessfullyEdited(
      name, genre, landlordType, cpfCnpj, phones, token)
      : super(
            name: name,
            genre: genre,
            landlordType: landlordType,
            cpfCnpj: cpfCnpj,
            phones: phones,
            token: token);

  @override
  List<Object> get props => super.props;

  @override
  String toString() => super.toString();
}

class EditProfileUserConfirmed extends EditMyProfileState {
  const EditProfileUserConfirmed();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditProfileUserConfirmed';
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
