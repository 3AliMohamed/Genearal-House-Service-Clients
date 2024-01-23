import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/models/requests/checkOut_order.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;
class CheckOutWebServices {
  static final CheckOutWebServices _singleton = CheckOutWebServices._internal();

  factory CheckOutWebServices() {
    return _singleton;
  }

  CheckOutWebServices._internal();
 // static Future<void> setOrder(Map<String,dynamic> orderMap)
 //  async{
 //   String? token =SharedPreferencesManager.getString('token');
 //    var headers = {
 //      'Accept-Language': 'ar',
 //      'api-token': 'gh-general',
 //      'Authorization': 'Bearer $token'
 //    };
 //    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().checkOut));
 //   // chosenOptions.forEach((key, value) {
 //   //   if (key == 'company_id') {
 //   //     request.fields[key] = value.toString();
 //   //   } else if (key == 'items' && value is List) {
 //   //     for (var item in value) {
 //   //       if (item is Map<String, dynamic>) {
 //   //         item.forEach((subKey, subValue) {
 //   //           request.fields['items[$index][$subKey]'] = subValue.toString();
 //   //         });
 //   //         index++;
 //   //       }
 //   //     }
 //   //   }
 //   // });
 //   //
 //   // request.headers.addAll(headers);
 //
 //   request.fields.addAll({
 //      'order_id': '115',
 //      'special_instructions': 'special_instructions',
 //      'comment': 'comment',
 //      'company_id': '18',
 //      'delivery_type_id': '9',
 //      'client_location_id': '12',
 //      'client_id': '27',
 //      'items[0][product_option_id]': '51',
 //      'items[0][quantity]': '2',
 //      'items[1][product_option_id]': '53',
 //      'items[1][quantity]': '6',
 //      'items[2][product_option_id]': '51',
 //      'items[2][quantity]': '4'
 //    });
 //
 //    request.headers.addAll(headers);
 //
 //    http.StreamedResponse response = await request.send();
 //
 //    if (response.statusCode == 200) {
 //      print(await response.stream.bytesToString());
 //    }
 //    else {
 //      print(response.reasonPhrase);
 //    }
 //
 //  }
  static Future<void> setOrder(Map<String, dynamic> orderMap) async {
    String? token = SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().checkOut));

    // Add headers to the request
    request.headers.addAll(headers);

    // Extract values from the orderMap and add them to the request fields
    orderMap.forEach((key, value) {
      if (value is List && key == 'items') {
        for (int i = 0; i < value.length; i++) {
          var item = value[i];
          request.fields['$key[$i][product_option_id]'] = '${item['product_option_id']}';
          request.fields['$key[$i][quantity]'] = '${item['quantity']}';
        }
      } else {
        request.fields[key] = value.toString();
      }
    });
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
