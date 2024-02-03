import 'dart:convert';

import 'package:general_house_service_clients/data_layer/models/responses/promo_code_reponse.dart';
import 'package:general_house_service_clients/data_layer/web_services/promo_code_web_services.dart';

class PromoCodeRepository{
  static final PromoCodeRepository _singleton = PromoCodeRepository._internal();

  factory PromoCodeRepository() {
    return _singleton;
  }
  PromoCodeRepository._internal();

 static Future<PromoCodeResponse> tryPromoCode(String orderId, String promoCode, String companyId)
  async{
        String promoCodeResponseString= await PromoCodeWebServices.tryPromoCode(orderId, promoCode, companyId);

        Map<String,dynamic> promoCodeResponseMap= jsonDecode(promoCodeResponseString);

        PromoCodeResponse promoCodeResponse = PromoCodeResponse.fromJson(promoCodeResponseMap);
        return promoCodeResponse;
  }

}