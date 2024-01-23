import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class GetCompanyWebServices{
  static final GetCompanyWebServices _singleton = GetCompanyWebServices._internal();

  factory GetCompanyWebServices() {
    return _singleton;
  }
  GetCompanyWebServices._internal();

  static Future<String> getCompany(int id)
 async{
   var headers = {
     'Accept-Language': 'ar',
     'api-token': 'gh-general'
   };
   var request = http.Request('GET', Uri.parse("${'${ApiUrls().getCompany}$id/category'})"));

   request.headers.addAll(headers);

   http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
     String companyResponse=await response.stream.bytesToString();
     return companyResponse;
   }
   else {
     return response.reasonPhrase!;
   }

 }

}