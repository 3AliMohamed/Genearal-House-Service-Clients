
import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/category_web_services.dart';
import 'package:general_house_service_clients/data_layer/web_services/company_web_services.dart';

import '../models/company_response.dart';
class CompanyRepository{

  static final CompanyRepository _singleton = CompanyRepository._internal();

  factory CompanyRepository() {
    return _singleton;
  }
  CompanyRepository._internal();


  static Future<List> getCompany({int? categoryId})
  async{
    List<dynamic> companies=[];
    dynamic companyResponseDynamic= await CompanyWebServices.getCompany(categoryId!);
    Map<String,dynamic> response= jsonDecode(companyResponseDynamic);
    companies=response['data'].map((company)=>CompanyData.fromJson(company)).toList();
    // fadel if condition 3la sttus == true lma mahmoud ye3melha
    return companies;
  }

}