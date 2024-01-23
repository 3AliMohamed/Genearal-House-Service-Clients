import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/states.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/get_profile_repository.dart';

import '../../../../data_layer/models/responses/get_profile_response.dart';

class ProfileCubit extends Cubit<ProfileStates>
{
  ProfileCubit() :super(InitialState());
  Map<int, List<ClientLocation>> clientLocationsMap = {};

  static ProfileCubit get(context) => BlocProvider.of(context);
  Future<void> getProfileData()
  async {
    emit(Loading());
    try{
    final  respons = await GetProfileRepository.getProfile();
    if (respons.data != null) {
      for (var profileData in respons.data!) {
        if (profileData.clientLocation != null) {
          clientLocationsMap[0] = profileData.clientLocation!;
        }
      }
    }
    emit(GetProfileDataSuccessState(respons));
    }catch(error){
      log("error in cubit:"+error.toString());
      emit(GetProfileDataErrorState(error));
    }
  }

}