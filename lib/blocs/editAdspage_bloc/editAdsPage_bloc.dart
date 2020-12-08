import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'editAdsPage_event.dart';
part 'editAdsPage_state.dart';

class EditAdsBloc extends Bloc<EditAdsEvent, EditAdsState> {
  AdRepository adRepository;

  EditAdsBloc({
    @required this.adRepository,
  }) : assert(adRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => InitEditAdsPage();

  @override
  Stream<EditAdsState> mapEventToState(EditAdsEvent event) async* {
    if (event is SubmitEditAds) {
      yield EditAdsLoadingPage();
      try {
        String token = await sharedPref.read('token');
        await adRepository.updateAdRepository(
            event.newAd, event.imagesAwsRemove, token);
        await Future.delayed(Duration(seconds: 5));
        yield SuccessOnEditSubmit();
      } catch (error) {
        //print(error);
        if (error is DioError) {
          yield EditAdsFailurePage(error: error.message);
        } else {
          yield EditAdsFailurePage(error: "500 - Internal Server Error");
        }
      }
    }
  }
}
