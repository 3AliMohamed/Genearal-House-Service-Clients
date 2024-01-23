import 'dart:convert';

import 'package:general_house_service_clients/data_layer/web_services/deleteAddress_web_services.dart';

class DeleteAddressRepository {
  static final DeleteAddressRepository _singleton = DeleteAddressRepository
      ._internal();

  factory DeleteAddressRepository() {
    return _singleton;
  }

  DeleteAddressRepository._internal();

 static Future<bool> deleteAddress(String id)
 async {
      String stringResponse= await DeleteAddressWebServices.deleteAddress(id);
      Map<String,dynamic> responseMap=jsonDecode(stringResponse);
      if(responseMap['status']=true)
        {
          return true;
        }
      else{
        return false ;
      }

 }
}