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
  get initialState => LoadingProfileDataEditing();

  returnInitialStateWithData() async {
    var newState;
    await returnDataForStateEditInitialData()
        .then((value) => newState = new EditProfileInitialData(
              value['name'],
              value['gender'],
              value['landlordType'],
              value['cpfCnpj'],
              value['phones'],
              value['token'],
            ));
    return newState;
  }

  Future<Map<dynamic, dynamic>> returnDataForStateEditInitialData() async {
    String name = await sharedPref.read('name');
    String gender = await sharedPref.read('genre');
    String landlordType = await sharedPref.read('landlordType');
    String cpfCnpj = await sharedPref.read('cpfCnpj');
    Map<dynamic, dynamic> phones = await sharedPref.read('phones');
    String token = await sharedPref.read('token');
    Phones newPhones = new Phones(
      telephone1: phones['telephone1'],
      telephone2: phones['telephone2'],
    );

    Map mapDataInitialData = {
      'name': name,
      'gender': gender,
      'landlordType': landlordType,
      'cpfCnpj': cpfCnpj,
      'phones': newPhones,
      'token': token,
    };
    return mapDataInitialData;
  }

  @override
  Stream<EditMyProfileState> mapEventToState(EditMyProfileEvent event) async* {
    print("passa no map");
    if (event is PageEditMyProfileStarted) {
      print("lala");
      var moss = await returnInitialStateWithData();
      yield moss;
    }
  }
}
