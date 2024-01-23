import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class CompanyWebServices{
  static final CompanyWebServices _singleton = CompanyWebServices._internal();

  factory CompanyWebServices() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CompanyWebServices._internal();

  static Future<dynamic> getCompany(int categoryId)
  async{
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general'
    };
    var request = http.Request('GET', Uri.parse('${ApiUrls().apiCategory}/$categoryId/company_with_categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     dynamic compResponse= await response.stream.bytesToString();
     // log(compResponse);
     return compResponse ;
    }
    else {
      print(response.reasonPhrase);
      return null ;
    }

  }
}