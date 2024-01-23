import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/responses/cart_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/cart_web_services.dart';

class CartRepository{
  static final CartRepository _singleton = CartRepository._internal();

  factory CartRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CartRepository._internal();

  static Future<CartResponse> getCart()
  async{
      String? stringResponse=await CartWebServices.getCart();
      Map<String,dynamic> response=jsonDecode(stringResponse!);
      List<dynamic> orderResponse=response['data'];
      List<Data>? orderData;
      // if(orderResponse !=null)
      //   {
          orderData= orderResponse.map((e) => Data.fromJson(e)).toList();
        // }
      CartResponse cartResponse =CartResponse(status: response['status'],
          data: orderData,message: response['message']);
      // cartResponse.data[0].order
      // log("repo"+response.toString());
    return cartResponse;
  }

}