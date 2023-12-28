import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class ProductWebServices {
  static final ProductWebServices _singleton = ProductWebServices._internal();

  factory ProductWebServices() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  ProductWebServices._internal();

  static Future<dynamic> getProduct(int categoryId ,int companyId)
  async{
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general'
    };
    var request = http.Request('GET', Uri.parse("${ApiUrls().apiProduct}?company_id=$companyId&category_id=$categoryId"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic productResponse=await response.stream.bytesToString();
      return productResponse;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }
}