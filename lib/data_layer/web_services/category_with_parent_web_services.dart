import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:http/http.dart' as http;

class CategoryWithParentWebServices{

  static final CategoryWithParentWebServices _singleton = CategoryWithParentWebServices._internal();

    factory CategoryWithParentWebServices() {
      return _singleton;
    }

    // validate if status is false then show the backend message and throw an exception
  CategoryWithParentWebServices._internal();
  static Future<dynamic> getCategory({int? parentId,int? companyId})
    async{
      var headers = {
        'Accept-Language': 'ar',
        'api-token': 'gh-general'
      };
      String queryParam = "?";
      if(parentId != null)
        queryParam += "parent_id=" + parentId.toString() + "&";
      if(companyId != null)
        queryParam += "company_id=" + companyId.toString()+ "&";

      var request = http.Request('GET', Uri.parse("${ApiUrls().apiCategory}$queryParam" ));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
       dynamic catResponse=await response.stream.bytesToString();
        return catResponse;
      }
      else
      {
        print(response.reasonPhrase);
        return null;
      }

    }

}
