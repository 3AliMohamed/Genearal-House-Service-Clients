import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/add_address/states.dart';
import 'package:general_house_service_clients/data_layer/repository/addAddress_repository.dart';

class AddAddressCubit extends Cubit<AddAddressStates>{
  AddAddressCubit() : super(InitialState());

  static AddAddressCubit get(context)=> BlocProvider.of(context);

  Future<bool> addAddress(String phone , String landLine, String streetName,
      String floor,String building, String apartmentNumber, String detailedAddress,String additionalAddress,String locationType,
      double long ,double lat)
  async{
    if(state is!Loading) {
      emit(Loading());
      final response = await AddAddressRepository.addAddress(
          phone,
          landLine,
          streetName,
          floor,
          building,
          apartmentNumber,
          detailedAddress,
          additionalAddress,
          locationType,
          long,
          lat);
      if (response.message == null) {
        emit(AddedSuccessfullyState());
        return true;
      } else {
        emit(AddErrorState(response.message));
        return false;
      }
    }
    else{
      return false;
    }
  }

}