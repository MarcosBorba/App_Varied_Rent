import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';

class CacheProviderAdProduct extends InheritedWidget {
  /* final List<Evaluation> evaluations;
  final List<QuestionAndAnswer> questionsAndAnswers;
  final int qtdEvaluations;
  final double adEvaluation;
  final String nameLocator;
  final String emailLocator;
  final String landlordTypeLocator;
  final String telephone1;
  final String telephone2; */
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final Widget child;
  CacheProviderAdProduct(
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProviderAdProduct of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProviderAdProduct>();
  }

  @override
  bool updateShouldNotify(CacheProviderAdProduct old) => true;
}
