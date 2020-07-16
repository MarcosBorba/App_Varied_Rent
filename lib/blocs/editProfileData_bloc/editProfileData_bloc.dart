import 'package:dio/dio.dart';
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

//TODO: nivel 4 - fazer bloc bem feito
  @override
  Stream<EditMyProfileState> mapEventToState(EditMyProfileEvent event) async* {
    if (event is PageEditMyProfileStarted) {
      try {
        yield await returnInitialStateWithData();
      } catch (error) {
        yield FailureProfileDataEditing(error: error.message);
      }
    } else if (event is SaveProfileDataButtonPressed) {
      yield LoadingProfileDataEditing();
      try {
        event.user.token = await sharedPref.read('token');
        String oldCpfCnpj = await sharedPref.read('cpfCnpj');
        await userRepository.userUpdateProfileRepository(
          event.user,
          event.user.token,
          oldCpfCnpj,
        );
        await replaceDataFromSharedPreferences(
          event.user,
        );
        yield DataProfileSuccessfullyEdited(
          event.user.name,
          event.user.genre,
          event.user.landlord_type,
          event.user.cpf_cnpj,
          event.user.phones,
          event.user.token,
        );
      } catch (error) {
        if (error is DioError) {
          yield FailureProfileDataEditing(error: error.message);
        } else {
          yield FailureProfileDataEditing(error: "500 - Internal Server Error");
        }
      }
    }
  }

  Future replaceDataFromSharedPreferences(User userUpdateProfile) async {
    try {
      await sharedPref.remove('name');
      await sharedPref.remove('genre');
      await sharedPref.remove('landlordType');
      await sharedPref.remove('cpfCnpj');
      await sharedPref.remove('phones');

      await sharedPref.save('name', userUpdateProfile.name);
      await sharedPref.save('genre', userUpdateProfile.genre);
      await sharedPref.save('landlordType', userUpdateProfile.landlord_type);
      await sharedPref.save('cpfCnpj', userUpdateProfile.cpf_cnpj);
      await sharedPref.save('phones', userUpdateProfile.phones);
    } catch (error) {
      throw new DioError(error: "500 - Error on save data");
    }
  }
}
