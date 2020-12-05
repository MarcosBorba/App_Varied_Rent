import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'insertAdsPage_event.dart';
part 'insertAdsPage_state.dart';

class InsertAdsBloc extends Bloc<InsertAdsEvent, InsertAdsState> {
  AdRepository adRepository;

  InsertAdsBloc({
    @required this.adRepository,
  }) : assert(adRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => InitInsertAdsPage();

  @override
  Stream<InsertAdsState> mapEventToState(InsertAdsEvent event) async* {
    if (event is SubmitNewAds) {
      yield InsertAdsLoadingPage();
      try {
        String token = await sharedPref.read('token');
        String locatorFk = await sharedPref.read('id');
        event.newAd.locator_fk = locatorFk;
        adRepository.addAdRepository(event.newAd, token);
        yield SuccessOnSubmit();
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield InsertAdsFailurePage(error: error.message);
        } else {
          yield InsertAdsFailurePage(error: "500 - Internal Server Error");
        }
      }
    }
  }
}
