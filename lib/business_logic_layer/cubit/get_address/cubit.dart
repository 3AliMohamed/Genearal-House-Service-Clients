import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/get_address/states.dart';
import 'package:general_house_service_clients/data_layer/repository/get_address_repository.dart';

import '../../../data_layer/models/responses/address_reponse.dart';
import '../../../data_layer/repository/deleteAddress_repository.dart';

class GetAddressCubit extends Cubit<GetAddressStates>{

  GetAddressCubit(): super( InitialState());
bool isChecked =false;
  List<bool> checkedItems=[];
  static GetAddressCubit get(context)=> BlocProvider.of(context);

   List<Data>? addressResponse;

  void getAddress()
  async{
    try {
      final response = await GetAddressRepository.getAddress();
        addressResponse=response.data!;
      this.checkedItems = List.generate(addressResponse!.length, (index) => false);

      emit(FetchAddressSuccess());
    }catch(error){
      emit(FetchAddressFailed());
    }
    }

  void deleteAddress(String id)
  async{
    emit(Loading());

    final response =await DeleteAddressRepository.deleteAddress(id);

    response ==true? emit(DeletedAddressSuccessfully()) : emit(DeletedAddressError());
  }
  void checked(value, index){
    checkedItems = List.generate(checkedItems.length, (index) => false);
    log("checkedItems[index] in cubit"+this.checkedItems[index].toString());
    this.checkedItems[index]=value;
    // isChecked = value!;
    log("in checked cubit:"+this.checkedItems[index].toString());
    emit(CheckboxUpdated());
  }

}