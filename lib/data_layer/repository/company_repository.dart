
import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/category_web_services.dart';
import 'package:general_house_service_clients/data_layer/web_services/company_web_services.dart';

import '../models/responses/company_response.dart';
class CompanyRepository{

  static final CompanyRepository _singleton = CompanyRepository._internal();

  factory CompanyRepository() {
    return _singleton;
  }
  CompanyRepository._internal();


  static Future<CompanyResponse> getCompany({int? categoryId})
  async{
    // List<Data> companies=[];
    dynamic companyResponseDynamic= await CompanyWebServices.getCompany(categoryId!);
    log('dynamic response');
    // log(companyResponseDynamic.toString());
    Map<String,dynamic> response= jsonDecode(companyResponseDynamic);
    CompanyResponse companyResponse=CompanyResponse.fromJson(response);
    return companyResponse;
  }

}