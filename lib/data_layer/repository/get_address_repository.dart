import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/responses/address_reponse.dart';
import 'package:general_house_service_clients/data_layer/web_services/get_address_web_services.dart';

class GetAddressRepository{
  static final GetAddressRepository _singleton = GetAddressRepository._internal();

  factory GetAddressRepository() {
    return _singleton;
  }
  GetAddressRepository._internal();


 static Future<AddressResponse> getAddress()async{
    String response= await GetAddressWebServices.getAddress();

    Map<String,dynamic> responseMap= jsonDecode(response);


    List<dynamic> data=responseMap['data'];

    List<Data> responseData=data.map((e) => Data.fromJson(e)).toList();

    AddressResponse addressResponse=AddressResponse(status: responseMap['status'],data: responseData,message: responseMap['message']);
    return addressResponse;
  }

}