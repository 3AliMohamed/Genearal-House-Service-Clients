import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/constants/end_points.dart';

import 'package:http/http.dart' as http;
class GetProfileWebServices {
  static final GetProfileWebServices _singleton = GetProfileWebServices
      ._internal();

  factory GetProfileWebServices() {
    return _singleton;
  }

  GetProfileWebServices._internal();

  static Future<dynamic> getProfile() async {
    String? token = SharedPreferencesManager.getString('token');


    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse(ApiUrls().getProfile));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic profileResponse = await response.stream.bytesToString();
      return profileResponse;
    }
    else {
      log("else web service"+response.reasonPhrase.toString());
      return null;

    }


  }
}