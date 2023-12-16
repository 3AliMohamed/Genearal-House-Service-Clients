import 'package:general_house_service_clients/data_layer/models/category_response.dart';

abstract class CategoryStates{}

class CategoryInitialState extends CategoryStates{}

class CategoryLoadedSuccessState extends CategoryStates{
  CategoryResponse response;
  CategoryLoadedSuccessState(this.response);

}

class CategoryLoadErrorState extends CategoryStates {
  dynamic error ;
  CategoryLoadErrorState(this.error);
}


class CategoryWithParentLoadedSuccessState extends CategoryStates{
  CategoryResponse response;
  CategoryWithParentLoadedSuccessState(this.response);

}

class CategoryWithParentLoadErrorState extends CategoryStates {
  dynamic error ;
  CategoryWithParentLoadErrorState(this.error);
}


