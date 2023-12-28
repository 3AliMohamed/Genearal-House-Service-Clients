import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/add_product_web_services.dart';

import '../models/requests/AddItemToOrderRequest.dart';

class AddProductRepository{
  static final AddProductRepository _singleton = AddProductRepository._internal();

  factory AddProductRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  AddProductRepository._internal();

  static Future<bool> setOrder(AddItemToOrderRequest chosenOptions)
  async{
    // log(chosenOptions.companyId.toString());
    // for(int i=0;i<chosenOptions.addItemToOrderRequestItems.length;i++){
    //   log("product option  :"+chosenOptions.addItemToOrderRequestItems[i].productOptionId.toString());
    //   log('quantity :'+chosenOptions.addItemToOrderRequestItems[i].quantity.toString());
    //   // chosenItem.map((e) => log(e.quantity.toString()));
    // }
    Map<String,dynamic> chosenOptionsMap=chosenOptions.toJson();
    log("repository" + chosenOptionsMap.toString());
    bool isSet=await AddProductWebServices.setOrder(chosenOptionsMap);
    return isSet;
  }


}