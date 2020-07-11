part of 'editAccountData_bloc.dart';

abstract class EditEmailAndPasswordEvents extends Equatable {
  const EditEmailAndPasswordEvents();
}

class EmailButtonConfirmUserPressed extends EditEmailAndPasswordEvents {
  final User user;
  const EmailButtonConfirmUserPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'EmailButtonConfirmUserPressed { user: $user}';
}

class PasswordButtonConfirmUserPressed extends EditEmailAndPasswordEvents {
  final User user;
  const PasswordButtonConfirmUserPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'PasswordButtonConfirmUserPressed { user: $user}';
}

class ConfirmEmailEditButtonPressed extends EditEmailAndPasswordEvents {
  final String newEmail;
  final String newEmailConfirmed;
  const ConfirmEmailEditButtonPressed(
      {@required this.newEmail, @required this.newEmailConfirmed});

  @override
  List<Object> get props => [newEmail, newEmailConfirmed];

  @override
  String toString() =>
      'ConfirmEmailEditButtonPressed - newEmail: { $newEmail } newEmailConfirmed: { $newEmailConfirmed }';
}

class ConfirmPasswordEditButtonPressed extends EditEmailAndPasswordEvents {
  final String newPassword;
  final String newPasswordConfirmed;
  const ConfirmPasswordEditButtonPressed(
      {@required this.newPassword, @required this.newPasswordConfirmed});

  @override
  List<Object> get props => [newPassword, newPasswordConfirmed];

  @override
  String toString() =>
      'ConfirmPasswordEditButtonPressed - newPassword: { $newPassword } newPasswordConfirmed: { $newPasswordConfirmed }';
}
