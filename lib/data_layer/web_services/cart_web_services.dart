import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class CartWebServices{

  static final CartWebServices _singleton = CartWebServices._internal();

  factory CartWebServices() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CartWebServices._internal();

  static Future<dynamic> getCart()
  async{
    dynamic token =SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse(ApiUrls().getCart));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic cartResponse= await response.stream.bytesToString();
      return cartResponse;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }
}