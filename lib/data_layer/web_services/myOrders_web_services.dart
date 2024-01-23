import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class MyOrdersWebServices {
  static final MyOrdersWebServices _singleton = MyOrdersWebServices._internal();

  factory MyOrdersWebServices() {
    return _singleton;
  }
  MyOrdersWebServices._internal();

   static Future<String> getMyOrder()
  async{
    String? token =SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(ApiUrls().myOrders));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String myOrders=await response.stream.bytesToString();
      return myOrders;
    }
    else {
      String? error=response.reasonPhrase;
      return error!;
    }

  }
}