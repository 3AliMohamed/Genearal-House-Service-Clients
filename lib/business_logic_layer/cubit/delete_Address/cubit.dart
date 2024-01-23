import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/delete_Address/states.dart';
import 'package:general_house_service_clients/data_layer/repository/deleteAddress_repository.dart';

class DeleteAddressCuibt extends Cubit<DeleteAddressStates>{
  DeleteAddressCuibt () : super(InitialState());
  static DeleteAddressCuibt get(context)=>BlocProvider.of(context);

  void deleteAddress(String id)
  async{
        emit(LoadingState());

        final response =await DeleteAddressRepository.deleteAddress(id);

        response ==true? emit(DeletedAddressSuccessfully()) : emit(DeletedAddressError());
  }
}