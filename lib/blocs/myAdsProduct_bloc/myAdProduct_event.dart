part of 'myAdProduct_bloc.dart';

abstract class MyAdProductPageEvent extends Equatable {
  const MyAdProductPageEvent();
}

class MyAdProductPageGetQuestionsAndEvaluations extends MyAdProductPageEvent {
  final String idAd;
  const MyAdProductPageGetQuestionsAndEvaluations(this.idAd);

  @override
  List<Object> get props => [idAd];

  @override
  String toString() => 'MyAdProductPageGetQuestionsAndEvaluations => $idAd';
}

class MyAdProductPageUpdateQuestionAndEvaluation extends MyAdProductPageEvent {
  final QuestionAndAnswer questionAndAnswer;
  const MyAdProductPageUpdateQuestionAndEvaluation(this.questionAndAnswer);

  @override
  List<Object> get props => [questionAndAnswer];

  @override
  String toString() => 'MyAdProductPageUpdateQuestionAndEvaluation';
}
