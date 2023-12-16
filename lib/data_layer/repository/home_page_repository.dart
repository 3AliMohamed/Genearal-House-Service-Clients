
import 'dart:convert';
import 'dart:developer';

import 'package:general_house_service_clients/data_layer/models/home_page_response.dart';
import 'package:general_house_service_clients/data_layer/web_services/home_page_web_services.dart';

class HomePageRepository{
  static final HomePageRepository _singleton = HomePageRepository._internal();

  factory HomePageRepository() {
    return _singleton;
  }

  // validate if status is false then show the backend message and throw an exception
  HomePageRepository._internal();

  static Future<HomePageData?> homePage()
  async{
    log("inside home_page_respo");
     dynamic home_page_response= await HomePageWebServices.homePage();
     Map<String,dynamic>response= jsonDecode(home_page_response);
    HomePageResponse homePageResponse= HomePageResponse(status: response['status'],message: response['message'],
    data: HomePageData.fromJson(response['data']));
    // Iterable<String>?images= homePageResponse.data?.homePage?.sliderImages?.map((image) => SliderImages.fromJson(image).toString());
    // log("images : "+images.toString() );
    // log("images :" +homePageResponse.data!.homePage!.sliderImages![0].imgPath.toString());
   // log(homePageResponse.data.homePage.sliderImages.toString());
    if(homePageResponse.status==true)
      {
        log("message : "+ homePageResponse.data.toString());
        return homePageResponse.data;
      }else{ return null;}
    // return home_page_response;

  }

}