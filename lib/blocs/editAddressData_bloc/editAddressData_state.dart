part of "./editAddressData_bloc.dart";

abstract class EditMyAddressState extends Equatable {
  const EditMyAddressState();

  @override
  List<Object> get props => [];
}

class EditAddressInitialData extends EditMyAddressState {
  final String token;
  final String country;
  final String state;
  final String city;
  final String zip_code;
  final String neighborhood;
  final String street;
  final String number;

  EditAddressInitialData({
    @required this.token,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.zip_code,
    @required this.neighborhood,
    @required this.street,
    @required this.number,
  });

  List<Object> get props =>
      [token, country, state, city, zip_code, neighborhood, street, number];

  String toString() =>
      'EditAddressInitialData { token: $token , country: $country, state: $state, city: $city, zip_code: $zip_code, neighborhood: $neighborhood, street: $street, number: $number }';
}

class DataAddressSuccessfullyEdited extends EditMyAddressState {
  final String token;
  final String country;
  final String state;
  final String city;
  final String zip_code;
  final String neighborhood;
  final String street;
  final String number;

  DataAddressSuccessfullyEdited({
    @required this.token,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.zip_code,
    @required this.neighborhood,
    @required this.street,
    @required this.number,
  });

  List<Object> get props =>
      [token, country, state, city, zip_code, neighborhood, street, number];

  String toString() =>
      'DataAddressSuccessfullyEdited { token: $token , country: $country, state: $state, city: $city, zip_code: $zip_code, neighborhood: $neighborhood, street: $street, number: $number }';
}

class LoadingAddressDataEditing extends EditMyAddressState {}

class FailureAddressDataEditing extends EditMyAddressState {
  final String error;

  const FailureAddressDataEditing({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureAddressDataEditing { error: $error }';
}
