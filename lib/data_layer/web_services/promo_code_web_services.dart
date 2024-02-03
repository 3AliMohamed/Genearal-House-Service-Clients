import 'dart:developer';

import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class PromoCodeWebServices{
  static final PromoCodeWebServices _singleton = PromoCodeWebServices._internal();

  factory PromoCodeWebServices() {
    return _singleton;
  }
  PromoCodeWebServices._internal();

 static Future<String> tryPromoCode(String orderId, String promoCode, String companyId)
  async{
    String? token =SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().promoCode));
    request.fields.addAll({
      'order_id': orderId,
      'promo_code': promoCode,
      'company_id': companyId
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String promoCodeResponse=await response.stream.bytesToString();
      return promoCodeResponse;
    }
    else {
      return response.reasonPhrase!;
    }

  }


}