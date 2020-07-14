import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'editProfileData_event.dart';
part 'editProfileData_state.dart';

class EditMyProfileBloc extends Bloc<EditMyProfileEvent, EditMyProfileState> {
  final UserRepository userRepository;

  EditMyProfileBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  SharedPref sharedPref = SharedPref();

  @override
  get initialState => returnInitialStateWithData();

  returnInitialStateWithData() async {
    Map mapDataInitialData = await returnDataForStateEditInitialData();

    var newState = new EditInitialData(
      mapDataInitialData['name'],
      mapDataInitialData['gender'],
      mapDataInitialData['landlordType'],
      mapDataInitialData['cpfCnpj'],
      mapDataInitialData['phones'],
      mapDataInitialData['token'],
    );
    return newState;
  }

  returnDataForStateEditInitialData() async {
    String name = await sharedPref.read('name');
    String gender = await sharedPref.read('genre');
    String landlordType = await sharedPref.read('landlord_type');
    String cpfCnpj = await sharedPref.read('cpf_cnpj');
    Phones phones = await sharedPref.read('phones');
    String token = await sharedPref.read('token');

    Map mapDataInitialData = {
      'name': name,
      'gender': gender,
      'landlordType': landlordType,
      'cpfCnpj': cpfCnpj,
      'phones': phones,
      'token': token,
    };
    return mapDataInitialData;
  }

  @override
  Stream<EditMyProfileState> mapEventToState(EditMyProfileEvent event) {
    if (event is SaveProfileDataButtonPressed) {
      var lala = event.user.name;
    }
  }
}
