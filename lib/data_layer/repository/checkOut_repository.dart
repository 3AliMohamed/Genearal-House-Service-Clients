import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/checkOut_web_services.dart';

import '../models/requests/checkOut_order.dart';

class CheckOutRepository{
  static final CheckOutRepository _singleton = CheckOutRepository._internal();

  factory CheckOutRepository() {
    return _singleton;
  }
  CheckOutRepository._internal();
 static Future<void> setOrder(CheckOutOrder checkOutOrder)
  async{
    Map<String,dynamic> orderMap=checkOutOrder.toJson();
    log("repository"+orderMap.toString());
    CheckOutWebServices.setOrder(orderMap);
  }

}