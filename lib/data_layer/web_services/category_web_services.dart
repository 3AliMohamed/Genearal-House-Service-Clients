
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class CategoryWebService {
  static final CategoryWebService _singleton = CategoryWebService._internal();

  factory CategoryWebService() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  CategoryWebService._internal();
  static Future<dynamic> getCategories()
  async{
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general'
    };
    var request = http.Request('GET', Uri.parse(ApiUrls().apiCategory));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic catResponse=await response.stream.bytesToString();
      // print(catResponse);
      return catResponse;
  }
  else {
      print(response.reasonPhrase);
      return null;
  }

  }
}