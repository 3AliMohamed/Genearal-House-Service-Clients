import 'dart:convert';
import 'dart:developer';

import '../../models/GetTransportationPeriod.dart';
import '../web_services/transportation_period.dart';

class TransportationPeriodRepository{

///
  static final TransportationPeriodRepository _singleton = TransportationPeriodRepository._internal();

  factory TransportationPeriodRepository() {
    return _singleton;
  }

  TransportationPeriodRepository._internal();


  static Future<List<TransportationPeriodData>?>  getTransportationPeriod(String userId, String date)
  async{
    dynamic TransportationPeriodResponseDynamic =await TransportationPeriodWebServices.getTransportationPeriod(userId, date);
    Map<String,dynamic> response= jsonDecode(TransportationPeriodResponseDynamic);
    if (response['status'] == true) {
      List<TransportationPeriodData> transportationPeriod = (response['data'] as List<dynamic>).map<TransportationPeriodData>
        ((transportationPeriod) =>
          TransportationPeriodData.fromJson(transportationPeriod)).toList();
      return transportationPeriod;
    } else {
      return null;
    }

  }

}