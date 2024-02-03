import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

class AddAddressWebServices{
  static final AddAddressWebServices _singleton = AddAddressWebServices._internal();

  factory AddAddressWebServices() {
    return _singleton;
  }

  AddAddressWebServices._internal();

  static Future<String> addAddress(String phone , String landLine, String streetName,
      String floor,String building, String apartmentNumber, String detailedAddress,String additionalAddress,String locationType,
      double long,double lat)
  async{
    String? token =SharedPreferencesManager.getString('token');
    var headers = {
      'Accept-Language': 'ar',
      'api-token': 'gh-general',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls().addAddress));
    request.fields.addAll({
      'lat': '$lat',
      'long': '$long',
      'phone_number': phone,
      'location_type': locationType,
      'street': streetName,
      'building': building,
      'floor': floor,
      'apartment': apartmentNumber,
      'detailed_address': detailedAddress,
      'additional_instructions': additionalAddress,
      'telephone': landLine
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String respons= await response.stream.bytesToString();
          return respons;
    }
    else {

      String? error= response.reasonPhrase;
      return error!;
    }

  }

}