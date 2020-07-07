part of 'editEmail_bloc.dart';

abstract class EditEmailEvent extends Equatable {
  const EditEmailEvent();
}

class EditEmailButtonConfirmUserPressed extends EditEmailEvent {
  final User user;
  const EditEmailButtonConfirmUserPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'EditEmailButtonConfirmUserPressed { user: $user}';
}

class EditEmailButtonConfirmEditEmailPressed extends EditEmailEvent {
  final String newEmail;
  final String newEmailConfirmed;
  const EditEmailButtonConfirmEditEmailPressed(
      {@required this.newEmail, @required this.newEmailConfirmed});

  @override
  List<Object> get props => [newEmail, newEmailConfirmed];

  @override
  String toString() =>
      'EditEmailButtonConfirmEditEmailPressed - newEmail: { $newEmail } newEmailConfirmed: { $newEmailConfirmed }';
}
