import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class DeleteItemFromCartWebServices{
  static final DeleteItemFromCartWebServices _singleton = DeleteItemFromCartWebServices._internal();

  factory DeleteItemFromCartWebServices() {
    return _singleton;
  }
  DeleteItemFromCartWebServices._internal();

  static Future<String> deleteItemFromCart(String orderId, String optionId)
  async{
    String? token = SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    log(optionId);
    log(orderId);
    var request = http.MultipartRequest('DELETE', Uri.parse('${ApiUrls().deleteItemFromCart}?order_id=$orderId&product_option_id=$optionId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String deleteItemResponse= await response.stream.bytesToString();

      return deleteItemResponse;
    }
    else {
      return response.reasonPhrase!;
    }

  }

  static Future<String> deleteCompany(String orderId)
  async{
    String? token =SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('DELETE', Uri.parse('${ApiUrls().deleteCompanyFromCart}?order_id=$orderId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String deleteResponse=await response.stream.bytesToString();
      return deleteResponse;
    }
    else {
      return response.reasonPhrase!;
    }

  }

}
