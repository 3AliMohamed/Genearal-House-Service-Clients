import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:general_house_service_clients/data_layer/web_services/delete_item_from_cart_web_services.dart';

class DeleteItemFromCartRepository{
  static final DeleteItemFromCartRepository _singleton = DeleteItemFromCartRepository._internal();

  factory DeleteItemFromCartRepository() {
    return _singleton;
  }
  DeleteItemFromCartRepository._internal();

  static Future <Map<String, dynamic>> deleteItemFromCart(String orderId, String optionId )
  async{
    String stringResponse= await DeleteItemFromCartWebServices.deleteItemFromCart(orderId, optionId);

    Map<String,dynamic> mapResponse= jsonDecode(stringResponse);
    return mapResponse;
  }
  static Future <Map<String, dynamic>> deleteCompany(String orderId)
  async{
        String stringResponse= await DeleteItemFromCartWebServices.deleteCompany(orderId);
        Map<String,dynamic> mapResponse =jsonDecode(stringResponse);
        return mapResponse;


  }


}
