part of 'myAdProduct_bloc.dart';

class MyAdProductPageState extends Equatable {
  const MyAdProductPageState();

  @override
  List<Object> get props => [];
}

class ShowQuestionsAndEvaluationsMyAdProductPage extends MyAdProductPageState {
  final List<QuestionAndAnswer> questionsAndAnswer;
  final List<Evaluation> evaluations;
  final double medianAmountStars;

  const ShowQuestionsAndEvaluationsMyAdProductPage({
    this.questionsAndAnswer,
    this.evaluations,
    this.medianAmountStars,
  });

  @override
  List<Object> get props =>
      [questionsAndAnswer, evaluations, medianAmountStars];

  @override
  String toString() => 'ShowQuestionsAndEvaluationsMyAdProductPage';
}

class LoadingMyAdProductPage extends MyAdProductPageState {}

class FailureMyAdProductPage extends MyAdProductPageState {
  final String error;

  const FailureMyAdProductPage({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailureMyAdProductPage { error: $error }';
}
