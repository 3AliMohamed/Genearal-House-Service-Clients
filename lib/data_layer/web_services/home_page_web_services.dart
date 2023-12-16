import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class HomePageWebServices{
  static final HomePageWebServices _singleton = HomePageWebServices._internal();

  factory HomePageWebServices() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  HomePageWebServices._internal();

  static Future <dynamic> homePage()
  async{
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general'
    };
    var request = http.Request('GET', Uri.parse(ApiUrls().apiHomePage));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("inside status code 200");
      dynamic home_page_response=await response.stream.bytesToString();
      log(home_page_response);
      return  home_page_response;
  }
  else {
  return null;
  print(response.reasonPhrase);
  }

  }

}