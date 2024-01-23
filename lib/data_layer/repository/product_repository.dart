import 'dart:convert';
import 'dart:core';



import 'package:general_house_service_clients/data_layer/models/responses/product_reposnse.dart';
import 'package:general_house_service_clients/data_layer/web_services/product_web_services.dart';

import '../models/responses/company_response.dart';
class ProductRepository{
  static final ProductRepository _singleton = ProductRepository._internal();

  factory ProductRepository() {
    return _singleton;
  }
  ProductRepository._internal();

  static Future<List<ProductData>?> getProduct(int categoryId, int companyId)
  async{
    // ProductData products;
    dynamic productResponseDynamic =await ProductWebServices.getProduct(categoryId, companyId);
      Map<String,dynamic> response= jsonDecode(productResponseDynamic);
    if (response['status'] == true) {
      List<ProductData> products = (response['data'] as List<dynamic>).map<ProductData>((product) => ProductData.fromJson(product)).toList();
      return products;
    } else {
      return null;
    }

  }

}