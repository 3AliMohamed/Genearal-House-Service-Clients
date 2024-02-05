import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/transportation_period/states.dart';

import '../../../data_layer/repository/transportation_period.dart';
import '../../../models/GetTransportationPeriod.dart';

class TransportationPeriodCubit extends Cubit<TransportationsPeriodStates> {
  TransportationPeriodCubit() : super(InitialState());

    static TransportationPeriodCubit get(context)=> BlocProvider.of(context);
  List<TransportationPeriodData> transportationPeriodPickupList = [];
  List<TransportationPeriodData> transportationPeriodDeliveryList = [];
   getTransportationPeriod(String userId,String date)async{
    emit(InitialState());
    try{
      final response =await TransportationPeriodRepository.getTransportationPeriod(userId, date);
      // transportatioPeriod=response!;
      log("in cubit:"+jsonEncode(response));
      transportationPeriodPickupList=response!;
      emit(SuccessState(response));
    }catch(error){
      log("error in TransportationPeriodCubit:"+error.toString());
      emit(FailedState(error));
    }
  }


  //

  getTransportationPeriodTwo(String userId,String date)async{
    emit(InitialState());
    try{
      final response =await TransportationPeriodRepository.getTransportationPeriod(userId, date);
      // transportatioPeriod=response!;
      log("in cubit:"+jsonEncode(response));
      transportationPeriodDeliveryList=response!;
      emit(SuccessState(response));
    }catch(error){
      log("error in TransportationPeriodCubit:"+error.toString());
      emit(FailedState(error));
    }
  }


}