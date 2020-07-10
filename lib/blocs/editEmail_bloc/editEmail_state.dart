part of 'editEmail_bloc.dart';

abstract class EditEmailAndPasswordState extends Equatable {
  const EditEmailAndPasswordState();

  @override
  List<Object> get props => [];
}

//EditEmailInitial é o estado inicial do EditEmailForm.
class EditInitialData extends EditEmailAndPasswordState {}

class DataSuccessfullyEdited extends EditEmailAndPasswordState {
  const DataSuccessfullyEdited();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DataSuccessfullyEdited';
}

class EditEmailConfirmedUser extends EditEmailAndPasswordState {
  const EditEmailConfirmedUser();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditEmailConfirmedUser';
}

class EditPasswordConfirmedUser extends EditEmailAndPasswordState {
  const EditPasswordConfirmedUser();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditPasswordConfirmedUser';
}

//EditEmailLoading é o estado do EditEmailForm quando validamos credenciais
class LoadingDataEditing extends EditEmailAndPasswordState {}

//EditEmailFailure é o estado do EditEmailForm quando uma tentativa de editar o email falha falha.
class FailureDataEditing extends EditEmailAndPasswordState {
  final String error;

  const FailureDataEditing({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureDataEditing { error: $error }';
}
