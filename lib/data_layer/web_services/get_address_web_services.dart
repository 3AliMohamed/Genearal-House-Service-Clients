import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class GetAddressWebServices{
  static final GetAddressWebServices _singleton = GetAddressWebServices._internal();

  factory GetAddressWebServices() {
    return _singleton;
  }
  GetAddressWebServices._internal();

  static Future<String> getAddress()
  async{
    String? token=SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(ApiUrls().getAddress));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseAddress=await response.stream.bytesToString();
      return responseAddress;
    }
    else {
      String? error= response.reasonPhrase;
      return error!;
    }

  }

}