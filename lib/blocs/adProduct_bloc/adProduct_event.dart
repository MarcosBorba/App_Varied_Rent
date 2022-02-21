part of 'adProduct_bloc.dart';

abstract class AdProductPageEvent extends Equatable {
  const AdProductPageEvent();
}

class AdProductPageGetInfoAd extends AdProductPageEvent {
  final String idAd;
  final String locatorFk;
  const AdProductPageGetInfoAd(this.idAd, this.locatorFk);

  @override
  List<Object> get props => [idAd, locatorFk];

  @override
  String toString() => 'AdProductPageGetInfoAd => $idAd, $locatorFk';
}

class AdProductPageAddFavoriteAd extends AdProductPageEvent {
  final String idAd;
  final String idUserLogged;
  const AdProductPageAddFavoriteAd(this.idAd, this.idUserLogged);

  @override
  List<Object> get props => [idAd, idUserLogged];

  @override
  String toString() => 'AdProductPageAddFavoriteAd => $idAd, $idUserLogged';
}

class AdProductPageRemoveFavoriteAd extends AdProductPageEvent {
  final String idAd;
  final String idUserLogged;
  const AdProductPageRemoveFavoriteAd(this.idAd, this.idUserLogged);

  @override
  List<Object> get props => [idAd, idUserLogged];

  @override
  String toString() => 'AdProductPageRemoveFavoriteAd => $idAd, $idUserLogged';
}

class AdProductPageAddQuestionAd extends AdProductPageEvent {
  final String idAd;
  final String question;
  final List<QuestionAndAnswer> questionsAndAnswer;
  const AdProductPageAddQuestionAd(
      this.idAd, this.question, this.questionsAndAnswer);

  @override
  List<Object> get props => [idAd, question, questionsAndAnswer];

  @override
  String toString() =>
      'AdProductPageAddQuestionAd => $idAd, $question, $questionsAndAnswer';
}

class AdProductPageEditQuestionAd extends AdProductPageEvent {
  final QuestionAndAnswer questionsAndAnswer;
  const AdProductPageEditQuestionAd(this.questionsAndAnswer);

  @override
  List<Object> get props => [questionsAndAnswer];

  @override
  String toString() => 'AdProductPageEditQuestionAd => $questionsAndAnswer';
}
