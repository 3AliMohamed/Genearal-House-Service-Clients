import 'package:general_house_service_clients/data_layer/web_services/authentication/logout_web_services.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';

import '../../models/responses/logout_response.dart';

class LogOutRepository{
  static final LogOutRepository _singleton = LogOutRepository._internal();

  factory LogOutRepository() {
    return _singleton;
  }
  LogOutRepository._internal();

  static Future<bool> logOut()
  async{
      dynamic dynamicResponse=await LogOutWebServices.logOut();

      LogoutResponse logOutResponse =LogoutResponse(status: dynamicResponse['status'],message: dynamicResponse['message']);
      if(logOutResponse.status=='success')
        {

          SharedPreferencesManager.clearUserSession();
          return true;
        }
      else{
        return false ;
      }

  }

}