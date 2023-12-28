import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/authentication/update_profile_web_services.dart';

class UpdateProfileRepository{
  static final UpdateProfileRepository _singleton = UpdateProfileRepository
      ._internal();

  factory UpdateProfileRepository() {
    return _singleton;
  }

  UpdateProfileRepository._internal();


  static Future<bool> updateProfile(String name, String phone, String gender,
      String email, String age, String country, String address, String password)

  async{
   final response= await UpdateProfileWebServices.updateProfile(name, phone, gender, email, age, country, address, password);
    Map<String,dynamic> responseMap= jsonDecode(response);
   if( responseMap['status']==true)
     {
       return true;
     }
   else{
     return false;
   }
  }

}