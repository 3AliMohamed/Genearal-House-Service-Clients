import 'dart:convert';
import 'dart:developer';
import 'package:general_house_service_clients/constants/end_points.dart';

import '';
import 'package:http/http.dart' as http;
var headers = {
 'Accept-Language': 'ar',
 'api-token': 'gh-general'
};

class LogInWebServices{
  Future<Map<String, dynamic>?> login(String email,String password)
async {

  var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().apiLogin));
  request.fields.addAll({
   'email': email,
   'password': password,
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
   var responseBody= await response.stream.bytesToString();
   Map<String, dynamic> responseJason = jsonDecode(responseBody);
   log("response in web service"+responseJason.toString());
   return responseJason;

 }
 else {
 print(response.reasonPhrase);
 return null;
 }

 }

}