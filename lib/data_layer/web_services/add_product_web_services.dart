// import '../models/requests/AddItemToOrderRequest.dart';
// import 'package:general_house_service_clients/constants/end_points.dart';
// import 'package:http/http.dart' as http;
// class AddProductWebServices{
//   static final AddProductWebServices _singleton = AddProductWebServices._internal();
//
//   factory AddProductWebServices() {
//     return _singleton;
//   }
//
//   // validate if status is false then show the backend message and throw an exception
//   AddProductWebServices._internal();
//
//   static void setOrder( Map<String,dynamic> chosenOptions)
//   {
//     var headers = {
//       'Accept-Language': 'ar',
//       'api-token': 'gh-general',
//       'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rldi5nZW5lcmFsaG91c2VzZXJ2aWNlcy5jb20vYXBpL2NsaWVudC9sb2dpbiIsImlhdCI6MTcwMzE3MjkxNiwibmJmIjoxNzAzMTcyOTE2LCJqdGkiOiJIWE5vUTBOV0E4bkx4WWxpIiwic3ViIjoiMjAiLCJwcnYiOiI0MWVmYjdiYWQ3ZjZmNjMyZTI0MDViZDNhNzkzYjhhNmJkZWM2Nzc3In0.q5stYoxeeL2fOS33AA8soadXqvQ87B8WYd1-jMS8Xa8'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse());
//     // chosenOptions.map((key, value) {});
//     request.fields.addAll({
//       'items[0][product_option_id]': '53',
//       'items[0][quantity]': '2',
//       'company_id': '18',
//       'items[1][product_option_id]': '50',
//       'items[1][quantity]': '3'
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//   }
//   else {
//   print(response.reasonPhrase);
//   }
//
//   }
//
// }


import 'dart:developer';

import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';

import '../models/requests/AddItemToOrderRequest.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class AddProductWebServices {
  static final AddProductWebServices _singleton = AddProductWebServices._internal();

  factory AddProductWebServices() {
    return _singleton;
  }

  AddProductWebServices._internal();

  static Future<dynamic> setOrder(Map<String, dynamic> chosenOptions) async {
    dynamic token=SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token' // Your authorization token here
    };

    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().addOrder));
    int index = 0;
    log("web services" + chosenOptions.toString());

    chosenOptions.forEach((key, value) {
      if (key == 'company_id') {
        request.fields[key] = value.toString();
      } else if (key == 'items' && value is List) {
        for (var item in value) {
          if (item is Map<String, dynamic>) {
            item.forEach((subKey, subValue) {
              request.fields['items[$index][$subKey]'] = subValue.toString();
            });
            index++;
          }
        }
      }
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
