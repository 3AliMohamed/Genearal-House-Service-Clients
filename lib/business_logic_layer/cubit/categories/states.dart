import 'package:general_house_service_clients/data_layer/models/responses/category_response.dart';

abstract class CategoryStates{}

class LoadingState extends CategoryStates{}

class InitialState extends CategoryStates{}

class LoadedSuccessfullyState extends CategoryStates{
  CategoryResponse response;
  LoadedSuccessfullyState(this.response);

}

class LoadingErrorState extends CategoryStates {
  dynamic error ;
  LoadingErrorState(this.error);
}




