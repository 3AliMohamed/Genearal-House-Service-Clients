import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;
class UpdateProfileWebServices{
  static final UpdateProfileWebServices _singleton = UpdateProfileWebServices
      ._internal();

  factory UpdateProfileWebServices() {
    return _singleton;
  }

  UpdateProfileWebServices._internal();

  static Future<dynamic> updateProfile(String name, String phone, String gender,
      String email, String age, String country, String address, String password)
 async {
    String? token= SharedPreferencesManager.getString('token');
    log(token.toString());
   var headers = {
     'Accept-Language': 'ar',
     'api-token': 'gh-general',
     'Authorization': 'Bearer $token'
   };
   var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().updateProfile));
   request.fields.addAll({
     'name': name,
     'email': email,
     'phone': phone,
     'age': age,
     'address': address,
     'gender': gender,
     'country_id': country,
     // 'password' : password
   });

   request.headers.addAll(headers);

   http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
     dynamic result =await response.stream.bytesToString();
     return result;
   }
   else {
     print(response.reasonPhrase);
     return null ;
   }

 }
}