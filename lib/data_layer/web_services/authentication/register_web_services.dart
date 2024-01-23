import 'dart:convert';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

var headers = {
  'Accept-Language': 'ar',
  'api-token': 'gh-general'
};

class RegisterWebServices {

  static  Future<dynamic> register(String email, String password,
      String name, String phone,
      String gender, String country_id
      )
  async {

    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().apiRegiser));
    request.fields.addAll({
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'age': '12',
      'address': 'mfkmokfmw',
      'gender': gender,
      'country id': country_id
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
      null;
    }

  }

}