import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/web_services/get_company_relatedOffer.dart';

import '../models/responses/company_response.dart';


class GetCompanyRepository{
  static final GetCompanyRepository _singleton = GetCompanyRepository._internal();

  factory GetCompanyRepository() {
    return _singleton;
  }
  GetCompanyRepository._internal();

  // Data? company;

  static Future<dynamic> getCompany(int id)
  async{

      String companyResponseString= await GetCompanyWebServices.getCompany(id);
      Map<String,dynamic> companyMap= jsonDecode(companyResponseString);
      if(companyMap['status']==true) {
        Data? company = Data.fromJson(companyMap['data'][0]);
        // log(company.id.toString());
        return company;
      }
      else{
        companyMap['message'];
      }
    // log(companyResponseString);
      // log(companyMap.toString());



  }


}