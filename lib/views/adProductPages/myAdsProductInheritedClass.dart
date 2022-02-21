import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';

class CacheProviderAdProduct extends InheritedWidget {
  final String idAd;
  final String nameLocator;
  final String emailLocator;
  final String landlordTypeLocator;
  final String telephone1;
  final String telephone2;
  final bool isFavorite;
  final bool isAnAnnouncementOfTheLoggedUser;
  final List<QuestionAndAnswer> questionsAndAnswers;
  final List<Evaluation> evaluations;
  final double adEvaluation;
  final int qtdEvaluations;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String userLoggedId;
  final String userLoggedEmail;
  final Widget child;
  CacheProviderAdProduct(
    this.idAd,
    this.nameLocator,
    this.emailLocator,
    this.landlordTypeLocator,
    this.telephone1,
    this.telephone2,
    this.isFavorite,
    this.isAnAnnouncementOfTheLoggedUser,
    this.questionsAndAnswers,
    this.evaluations,
    this.adEvaluation,
    this.qtdEvaluations,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
    this.userLoggedId,
    this.userLoggedEmail,
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
