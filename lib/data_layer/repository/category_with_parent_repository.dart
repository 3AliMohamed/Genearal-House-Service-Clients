
import 'dart:convert';

import 'package:general_house_service_clients/data_layer/web_services/category_with_parent_web_services.dart';

import '../models/category_response.dart';

class CategoryWithParentRepository{
  static final CategoryWithParentRepository _singleton = CategoryWithParentRepository._internal();

  factory CategoryWithParentRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CategoryWithParentRepository._internal();

  static Future<CategoryResponse>  getCategory({int? parentId,int? companyId})
  async {
    dynamic categoryWithParentResponseDynamic= await CategoryWithParentWebServices.getCategory(parentId:parentId,companyId:companyId);
    Map<String,dynamic> response=jsonDecode(categoryWithParentResponseDynamic);
    CategoryResponse categoryWithParentResponse =CategoryResponse(status: response['status'],
        data: Data.fromJson(response['data']),
        message: response['message']
    );
    return categoryWithParentResponse;
  }
}