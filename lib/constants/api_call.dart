import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Map<String,dynamic>?> apiCall(String methode,String apiurl,Map<String,dynamic>header)
  async {
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general'
    };
    var request = http.MultipartRequest(methode, Uri.parse(apiurl));
    request.fields.addAll(header! as Map<String, String>);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody=await response.stream.bytesToString();
      Map<String, dynamic> responseJason = json.decode(responseBody);
      print(responseJason);
      return responseJason;
    }
    else {
      print(response.reasonPhrase);
      return null ;
    }

  }
