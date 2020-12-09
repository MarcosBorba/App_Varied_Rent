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
      ];

  @override
  String toString() => 'ShowInfoAdMyAdProductPage';
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
