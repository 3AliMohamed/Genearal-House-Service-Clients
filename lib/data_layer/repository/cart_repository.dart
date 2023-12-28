import 'package:general_house_service_clients/data_layer/web_services/cart_web_services.dart';

class CartRepository{
  static final CartRepository _singleton = CartRepository._internal();

  factory CartRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CartRepository._internal();

  Future<dynamic> getCart()
  async{
      dynamic DynamicResponse=CartWebServices.getCart();

  }

}