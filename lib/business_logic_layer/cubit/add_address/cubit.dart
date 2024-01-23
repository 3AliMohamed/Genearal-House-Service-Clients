import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/add_address/states.dart';
import 'package:general_house_service_clients/data_layer/repository/addAddress_repository.dart';

class AddAddressCubit extends Cubit<AddAddressStates>{
  AddAddressCubit() : super(InitialState());

  static AddAddressCubit get(context)=> BlocProvider.of(context);

  void addAddress(String phone , String landLine, String streetName,
      String floor,String building, String apartmentNumber, String detailedAddress,String additionalAddress,String locationType
      )
  async{
    emit(Loading());


           final response = await AddAddressRepository.addAddress(phone, landLine, streetName, floor, building,
               apartmentNumber, detailedAddress, additionalAddress,locationType);
           if(response.message==null){
                emit(AddedSuccessfullyState());
         }else{emit(AddErrorState(response.message));}
  }

}