import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/authentication/register_web_services.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';


class RegisterRepository{
  static Future<Map<String, dynamic>> register(String email, String password, String name, String phone,  String gender, String country_id )
  async{
    final registerresponse = await RegisterWebServices.register(email, password, name, phone,  gender, country_id);
    // print(registerresponse.runtimeType);
    Map<String,dynamic> response_json=jsonDecode(registerresponse);
    return response_json;
  }

}