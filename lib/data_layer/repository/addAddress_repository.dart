import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/responses/addAddress_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/addAddres_web_services.dart';

class AddAddressRepository {
  static final AddAddressRepository _singleton = AddAddressRepository._internal();

  factory AddAddressRepository() {
    return _singleton;
  }

  AddAddressRepository._internal();
  static Future<AddAddressResponse> addAddress(String phone , String landLine, String streetName,
      String floor,String building, String apartmentNumber, String detailedAddress,String additionalAddress,String locationType
      )
  async{
    final response =await AddAddressWebServices.addAddress(phone, landLine, streetName, floor, building, apartmentNumber,
        detailedAddress, additionalAddress,locationType);
        Map<String,dynamic>responseMap= jsonDecode(response);
        AddAddressResponse addressResponse=AddAddressResponse.fromJson(responseMap);
        return addressResponse;
  }

}