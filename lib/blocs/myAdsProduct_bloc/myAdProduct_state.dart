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
  final String nameLocator;
  final String landlordTypeLocator;
  final String telephone1;
  final String telephone2;
  final String emailLocator;

  const ShowQuestionsAndEvaluationsMyAdProductPage({
    this.questionsAndAnswer,
    this.evaluations,
    this.medianAmountStars,
    this.nameLocator,
    this.emailLocator,
    this.landlordTypeLocator,
    this.telephone1,
    this.telephone2,
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
        telephone2
      ];

  @override
  String toString() => 'ShowQuestionsAndEvaluationsMyAdProductPage';
}

class ShowUpdateQuestionsAndEvaluationsMyAdProductPage
    extends MyAdProductPageState {
  const ShowUpdateQuestionsAndEvaluationsMyAdProductPage();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ShowUpdateQuestionsAndEvaluationsMyAdProductPage';
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
