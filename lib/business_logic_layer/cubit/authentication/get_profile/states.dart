import 'package:general_house_service_clients/data_layer/models/get_profile_response.dart';

abstract class ProfileStates {}

class InitialState extends ProfileStates{}

class GetProfileDataSuccessState extends ProfileStates{
  ProfileResponse response;
  GetProfileDataSuccessState(this.response);
}

class GetProfileDataErrorState extends ProfileStates{
  dynamic error ;
  GetProfileDataErrorState(this.error);
}

