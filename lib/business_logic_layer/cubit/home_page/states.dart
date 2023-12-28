import 'package:general_house_service_clients/data_layer/models/home_page_response.dart';

abstract class HomePageStates {}

class HomePageInitialState extends HomePageStates{}

class FetchHomePageSuccessState extends HomePageStates{
  HomePageData response;
  FetchHomePageSuccessState(this.response);
}

