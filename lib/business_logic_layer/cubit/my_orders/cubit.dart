import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/states.dart';
import 'package:general_house_service_clients/data_layer/repository/myOrders_repository.dart';

class MyOrdersCubit extends Cubit<MyOrdersStates> {
  MyOrdersCubit() : super(InitialState());

  static  MyOrdersCubit get(context)=> BlocProvider.of(context);

  void getMyOrders()async{
    emit(Loading());
    try{
      final response =await MyOrdersRepository.getMyOrders();
      emit(FetchedSuccessfully(response!));
    }catch(error){
      emit(FetchError(error));
    }
  }


}