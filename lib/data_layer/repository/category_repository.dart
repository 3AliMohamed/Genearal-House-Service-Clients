import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/category_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/category_web_services.dart';

class CategoryRepository{
  static final CategoryRepository _singleton = CategoryRepository._internal();

  factory CategoryRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CategoryRepository._internal();
  static Future<CategoryResponse>  getCategory()
 async {
      dynamic categoryResponseDynamic= await CategoryWebService.getCategories();
      // log(categoryResponseDynamic);
      Map<String,dynamic> response=jsonDecode(categoryResponseDynamic);
      CategoryResponse categoryResponse =CategoryResponse(status: response['status'],
      data: Data.fromJson(response['data']),
        message: response['message']
      );
      // log(categoryResponse.data!.categories![0].imgPath.toString());
      return categoryResponse;
  }
}