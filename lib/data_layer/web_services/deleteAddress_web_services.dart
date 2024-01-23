import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class DeleteAddressWebServices {
  static final DeleteAddressWebServices _singleton = DeleteAddressWebServices
      ._internal();

  factory DeleteAddressWebServices() {
    return _singleton;
  }

  DeleteAddressWebServices._internal();

  static Future<String> deleteAddress(String id)
  async {
    String? token= SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('DELETE', Uri.parse(ApiUrls().deleteAddress+id));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String deleteResponse= await response.stream.bytesToString();
      return deleteResponse;
    }
    else {
      String? error=response.reasonPhrase;
      return error!;
    }

  }
}