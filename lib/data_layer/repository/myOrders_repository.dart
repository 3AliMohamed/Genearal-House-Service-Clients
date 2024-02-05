import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/responses/myOrders_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/myOrders_web_services.dart';

class MyOrdersRepository {
  static final MyOrdersRepository _singleton = MyOrdersRepository._internal();

  factory MyOrdersRepository() {
    return _singleton;
  }

  MyOrdersRepository._internal();

  static Future<MyOrdersResponse?> getMyOrders()
  async{
    String response= await MyOrdersWebServices.getMyOrder();

    Map<String,dynamic> responseMap=jsonDecode(response);

    if(responseMap['status']==true){
      MyOrdersResponse myOrdersResponse=MyOrdersResponse.fromJson(responseMap);
      return myOrdersResponse;
    }
    else{
      log(responseMap['message']);
      return null;
    }

  }
}