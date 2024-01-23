
import 'package:general_house_service_clients/data_layer/models/responses/myOrders_response.dart';

abstract class MyOrdersStates{}

class InitialState extends MyOrdersStates{}

class Loading extends MyOrdersStates{}

class FetchedSuccessfully extends MyOrdersStates{
  MyOrdersResponse response;
  FetchedSuccessfully(this.response);
}

class FetchError extends MyOrdersStates{
  dynamic error ;
  FetchError(this.error);
}

