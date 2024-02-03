import 'package:general_house_service_clients/data_layer/models/responses/cart_response.dart';

abstract class CartStates{}

class InitialState extends CartStates{}

class FetchDataSuccessState extends CartStates{
  CartResponse response;
  FetchDataSuccessState(this.response);

}

class FetchDataErrorState extends CartStates{
  dynamic error;
  FetchDataErrorState(this.error);

}

class LoadingState extends CartStates{}

class IncrementState extends CartStates{}

class DecrementState extends CartStates{}



class CalculatedState extends CartStates{}

class ItemDeletedSuccessfully extends CartStates{}

class ItemDeleteError extends CartStates{}


class CompanyDeletedSuccessfully extends CartStates{}

class CompanyDeleteError extends CartStates{}


