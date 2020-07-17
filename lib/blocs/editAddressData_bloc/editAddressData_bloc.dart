import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'editAddressData_event.dart';
part 'editAddressData_state.dart';

class EditMyAddressBloc extends Bloc<EditMyAddressEvent, EditMyAddressState> {
  UserRepository userRepository;

  EditMyAddressBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  SharedPref sharedPref = SharedPref();

  @override
  get initialState => LoadingAddressDataEditing();

  @override
  Stream<EditMyAddressState> mapEventToState(EditMyAddressEvent event) async* {
    if (event is PageEditMyAddressStarted) {
      try {
        yield await returnInitialStateWithData();
      } catch (error) {
        yield FailureAddressDataEditing(error: error.message);
      }
    } else if (event is SaveAddressDataButtonPressed) {
      yield LoadingAddressDataEditing();
      try {
        event.user.token = await sharedPref.read('token');
        String email = await sharedPref.read('email');
        await userRepository.userUpdateAddressRepository(
          event.user.address,
          event.user.token,
          email,
        );
        await replaceDataFromSharedPreferences(
          event.user.address,
        );

        yield DataAddressSuccessfullyEdited(
          token: event.user.token,
          country: event.user.address.country,
          state: event.user.address.state,
          city: event.user.address.city,
          zip_code: event.user.address.zip_code,
          neighborhood: event.user.address.neighborhood,
          street: event.user.address.street,
          number: event.user.address.number,
        );
      } catch (error) {
        if (error is DioError) {
          yield FailureAddressDataEditing(error: error.message);
        } else {
          yield FailureAddressDataEditing(error: "500 - Internal Server Error");
        }
      }
    }
  }

  returnInitialStateWithData() async {
    var newState;
    await returnDataForStateEditInitialData()
        .then((value) => newState = new EditAddressInitialData(
              token: value['token'],
              country: value['country'],
              state: value['state'],
              city: value['city'],
              zip_code: value['zip_code'],
              neighborhood: value['neighborhood'],
              street: value['street'],
              number: value['number'],
            ));
    return newState;
  }

  Future<Map<dynamic, dynamic>> returnDataForStateEditInitialData() async {
    Map<dynamic, dynamic> address = await sharedPref.read('address');
    String token = await sharedPref.read('token');
    Address newAddress = new Address(
      country: address['country'],
      state: address["state"],
      city: address['city'],
      zip_code: address['zip_code'],
      neighborhood: address['neighborhood'],
      street: address['street'],
      number: address['number'],
    );

    Map mapDataInitialData = {
      'token': token,
      'country': newAddress.country,
      'state': newAddress.state,
      'city': newAddress.city,
      'zip_code': newAddress.zip_code,
      'neighborhood': newAddress.neighborhood,
      'street': newAddress.street,
      'number': newAddress.number,
    };
    return mapDataInitialData;
  }

  Future replaceDataFromSharedPreferences(Address userUpdateAddress) async {
    try {
      await sharedPref.remove('address');
      await sharedPref.save('address', userUpdateAddress);
    } catch (error) {
      throw new DioError(error: "500 - Error on save data");
    }
  }
}
