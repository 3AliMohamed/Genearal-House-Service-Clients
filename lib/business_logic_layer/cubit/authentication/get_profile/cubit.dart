import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/states.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/get_profile_repository.dart';

class ProfileCubit extends Cubit<ProfileStates>
{
  ProfileCubit() :super(InitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  Future<void> getProfileData()
  async {
    try{
    final  respons = await GetProfileRepository.getProfile();
    emit(GetProfileDataSuccessState(respons));
    }catch(error){
      log("error in cubit:"+error.toString());
      emit(GetProfileDataErrorState(error));
    }
  }

}