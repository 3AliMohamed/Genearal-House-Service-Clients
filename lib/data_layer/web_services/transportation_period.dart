import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../helpers/SharedPrefManager.dart';
import '../../models/GetTransportationPeriod.dart';



class TransportationPeriodWebServices {
  static final TransportationPeriodWebServices _singleton = TransportationPeriodWebServices._internal();

  factory TransportationPeriodWebServices() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  TransportationPeriodWebServices._internal();

  static Future getTransportationPeriod(String userId ,String date)
  async{
    String? token =SharedPreferencesManager.getString('token');
    var headers = {
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse('https://dev.generalhouseservices.com/api/transportation_periods_assigned_to_drivers/select?user_id=$userId&date=$date'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic periods=await response.stream.bytesToString();
      log("in web service"+periods.toString());
      return periods;
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      String? error=response.reasonPhrase;
      return error!;
    }


  }
}


