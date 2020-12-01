import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';

class CacheProvider extends InheritedWidget {
  final List<Evaluation> evaluations;
  final List<QuestionAndAnswer> questionsAndAnswers;
  final int qtdEvaluations;
  final double adEvaluation;
  final String nameLocator;
  final String landlordTypeLocator;
  final String telephone1;
  final String telephone2;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final Widget child;
  CacheProvider(
    this.evaluations,
    this.questionsAndAnswers,
    this.qtdEvaluations,
    this.adEvaluation,
    this.nameLocator,
    this.landlordTypeLocator,
    this.telephone1,
    this.telephone2,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProvider>();
  }

  @override
  bool updateShouldNotify(CacheProvider old) => true;
}
