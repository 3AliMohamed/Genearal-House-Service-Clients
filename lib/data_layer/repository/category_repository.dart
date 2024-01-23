
import 'dart:convert';

import 'package:general_house_service_clients/data_layer/web_services/category_web_services.dart';

import '../models/responses/category_response.dart';

class CategoryRepository{
  static final CategoryRepository _singleton = CategoryRepository._internal();

  factory CategoryRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CategoryRepository._internal();

  static Future<CategoryResponse?>  getCategory({int? parentId,int? companyId})
  async {
    dynamic categoryWithParentResponseDynamic= await CategoryWebServices.getCategory(parentId:parentId,companyId:companyId);
    Map<String,dynamic> response=jsonDecode(categoryWithParentResponseDynamic);
    CategoryResponse categoryWithParentResponse =CategoryResponse(status: response['status'],
        data: Data.fromJson(response['data']),
        message: response['message']
    );
    if(categoryWithParentResponse.status==true)
      {
        return categoryWithParentResponse;
      }
    else{return null ;}
  }
}