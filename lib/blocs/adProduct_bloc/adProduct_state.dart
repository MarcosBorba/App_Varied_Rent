part of 'adProduct_bloc.dart';

class AdProductPageState extends Equatable {
  const AdProductPageState();

  @override
  List<Object> get props => [];
}

class ShowInfoAdMyAdProductPage extends AdProductPageState {
  final List<QuestionAndAnswer> questionsAndAnswer;
  final List<Evaluation> evaluations;
  final double medianAmountStars;
  final String nameLocator;
  final String landlordTypeLocator;
  final String telephone1;
  final String telephone2;
  final String emailLocator;
  final bool isFavorite;
  final String userLoggedEmail;
  final String userLoggedId;
  final bool isAnAnnouncementOfTheLoggedUser;

  const ShowInfoAdMyAdProductPage({
    this.questionsAndAnswer,
    this.evaluations,
    this.medianAmountStars,
    this.nameLocator,
    this.emailLocator,
    this.landlordTypeLocator,
    this.telephone1,
    this.telephone2,
    this.isFavorite,
    this.userLoggedEmail,
    this.userLoggedId,
    this.isAnAnnouncementOfTheLoggedUser,
  });

  @override
  List<Object> get props => [
        questionsAndAnswer,
        evaluations,
        medianAmountStars,
        nameLocator,
        emailLocator,
        landlordTypeLocator,
        telephone1,
        telephone2,
        isFavorite,
        userLoggedEmail,
        userLoggedId,
        isAnAnnouncementOfTheLoggedUser,
      ];

  @override
  String toString() => 'ShowInfoAdMyAdProductPage';
}

class RemoveFavoriteAdMyAdProductPage extends AdProductPageState {
  final bool isFavorite;

  RemoveFavoriteAdMyAdProductPage({this.isFavorite});

  @override
  List<Object> get props => [isFavorite];

  @override
  String toString() =>
      'RemoveFavoriteAdMyAdProductPage { favorite: $isFavorite }';
}

class AddFavoriteAdMyAdProductPage extends AdProductPageState {
  final bool isFavorite;

  AddFavoriteAdMyAdProductPage({this.isFavorite});

  @override
  List<Object> get props => [isFavorite];

  @override
  String toString() => 'AddFavoriteAdMyAdProductPage { favorite: $isFavorite }';
}

class AddQuestionAdMyAdProductPage extends AdProductPageState {
  final List<QuestionAndAnswer> questionAndAnswer;

  AddQuestionAdMyAdProductPage({this.questionAndAnswer});

  @override
  List<Object> get props => [questionAndAnswer];

  @override
  String toString() =>
      'AddQuestionAdMyAdProductPage { idAd: $questionAndAnswer }';
}

class EditQuestionAdMyAdProductPage extends AdProductPageState {
  EditQuestionAdMyAdProductPage();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditQuestionAdMyAdProductPage';
}

class LoadingAdProductPage extends AdProductPageState {}

class FailureAdProductPage extends AdProductPageState {
  final String error;

  const FailureAdProductPage({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureAdProductPage { error: $error }';
}
