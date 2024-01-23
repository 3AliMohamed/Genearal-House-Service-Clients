import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/responses/get_profile_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/authentication/get_profile_web_services.dart';

class GetProfileRepository {
  static final GetProfileRepository _singleton = GetProfileRepository
      ._internal();

  factory GetProfileRepository() {
    return _singleton;
  }

  GetProfileRepository._internal();

 static Future<ProfileResponse> getProfile()
  async{
    final response=await GetProfileWebServices.getProfile();
    // log("res :" +response.toString());

    Map<String,dynamic> responseMap= jsonDecode(response);
    List<dynamic>? responseData = responseMap['data'];

    // Convert List<dynamic> to List<ProfileData>
    List<ProfileData>? profileDataList;
    if (responseData != null) {
      profileDataList = responseData.map((data) => ProfileData.fromJson(data)).toList();
    }

    ProfileResponse profileResponse= ProfileResponse(status: responseMap['status'],
        data: profileDataList,message: responseMap['message']);

    return profileResponse;
  }

}