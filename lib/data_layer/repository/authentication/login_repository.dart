import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';

import '../../models/login_response.dart';
import '../../web_services/authentication/login_web_services.dart';

class LogInRepository{

  final LogInWebServices loginWebServices;

  LogInRepository(this.loginWebServices);

  Future<Data?> login(String email,String password)
  async{
    // try{
      final  loginresponse=  await loginWebServices.login(email,password);
      // log("repository_login_Response "+ loginresponse.toString());
      LoginResponse login_response=LoginResponse(status: loginresponse!['status'],
          data:Data.fromJson(loginresponse['data']),
          message: loginresponse!['message'],
      );
      if(login_response.status!=null)
      {
        // log(login_response.data.email);
        SharedPreferencesManager.setString('name', login_response.data!.name.toString());
        SharedPreferencesManager.setString('phone', login_response.data!.phone.toString());
        SharedPreferencesManager.setString('age', login_response.data!.age.toString());
        SharedPreferencesManager.setString('country', login_response.data!.countryId.toString());
        SharedPreferencesManager.setString('address', login_response.data!.address.toString());
        SharedPreferencesManager.setString('gender', login_response.data!.gender.toString());
        // SharedPreferencesManager.setString('password', login_response.data!..toString());
        SharedPreferencesManager.setString('token', login_response.data!.token.toString());
        SharedPreferencesManager.setString('email', login_response.data!.email.toString());
        SharedPreferencesManager.setString('password', password);
        SharedPreferencesManager.setString('lang', 'English');

        SharedPreferencesManager.setBool('is_login',true);

        // log("email: "+login_response.data!.email.toString());
        return  login_response.data;
      } 
      else
        {
          print('login returned null');
          return null;
        }
    // }catch(e){
    //     print("An error occurred: $e");
    // }

  }

}