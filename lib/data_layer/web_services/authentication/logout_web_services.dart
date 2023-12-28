import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class LogOutWebServices {
  static final LogOutWebServices _singleton = LogOutWebServices._internal();

  factory LogOutWebServices() {
    return _singleton;
  }
  LogOutWebServices._internal();

  static Future<dynamic> logOut()
  async{
    dynamic token= SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse(ApiUrls().logOut));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic logoutResponse= await response.stream.bytesToString();
      return logoutResponse;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

}