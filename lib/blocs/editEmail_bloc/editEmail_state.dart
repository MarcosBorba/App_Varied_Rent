part of 'editEmail_bloc.dart';

abstract class EditEmailState extends Equatable {
  const EditEmailState();

  @override
  List<Object> get props => [];
}

//EditEmailInitial é o estado inicial do EditEmailForm.
class EditEmailInitial extends EditEmailState {}

class EditEmailSuccessfullyConcluded extends EditEmailState {
  const EditEmailSuccessfullyConcluded();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditEmailSuccessfullyConcluded';
}

class EditEmailConfirmedUser extends EditEmailState {
  const EditEmailConfirmedUser();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditEmailConfirmedUser';
}

//EditEmailLoading é o estado do EditEmailForm quando validamos credenciais
class EditEmailLoading extends EditEmailState {}

//EditEmailFailure é o estado do EditEmailForm quando uma tentativa de editar o email falha falha.
class EditEmailFailure extends EditEmailState {
  final String error;

  const EditEmailFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EditEmailFailure { error: $error }';
}
