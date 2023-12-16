abstract class HomePageStates {}

class HomePageInitialState extends HomePageStates{}

class FetchHomePageSuccessState extends HomePageStates{
  dynamic response;
  FetchHomePageSuccessState(this.response);
}

