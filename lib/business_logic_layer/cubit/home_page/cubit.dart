import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/home_page_repository.dart';

class HomePageCubit extends Cubit<HomePageStates>
{
  HomePageCubit() :super(HomePageInitialState());

  static HomePageCubit get(context)=> BlocProvider.of(context);

  List<String> sliderImages=[];
  void fetchHomePageData()
  {
    HomePageRepository.homePage().then((response){
      log("cubit response :"+response!.homePage!.toString());
      for(int i = 0;i <response!.homePage!.sliderImages!.length;i++)
        {
          sliderImages.add(ApiUrls().apiUrl+response!.homePage!.sliderImages![i].imgPath.toString());
        }
      emit(FetchHomePageSuccessState(response)); 
    }).catchError((error){
      log("error : "+error.toString());
    });
  }

}