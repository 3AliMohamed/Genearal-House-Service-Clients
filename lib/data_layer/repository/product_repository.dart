import 'dart:convert';
import 'dart:developer';


import 'package:general_house_service_clients/data_layer/models/product_reposnse.dart';
import 'package:general_house_service_clients/data_layer/web_services/product_web_services.dart';

import '../models/company_response.dart';
class ProductRepository{
  static final ProductRepository _singleton = ProductRepository._internal();

  factory ProductRepository() {
    return _singleton;
  }
  ProductRepository._internal();

  static Future<dynamic> getProduct(int categoryId, int companyId)
  async{
    List<dynamic> products=[];
    dynamic productResponseDynamic =await ProductWebServices.getProduct(categoryId, companyId);
      Map<String,dynamic> response= jsonDecode(productResponseDynamic);
      if(response['status']==true)
        {
          products=response['data'].map((product)=> ProductData.fromJson(product)).toList();
          return products;
        }
      else
        {
          return null;
        }

  }

}