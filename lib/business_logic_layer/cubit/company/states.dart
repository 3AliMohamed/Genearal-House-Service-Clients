import 'package:general_house_service_clients/data_layer/models/responses/company_response.dart';

abstract class CompanyStates{}

class InitialState extends CompanyStates{}

class LoadingState extends CompanyStates{}

class LoadedSuccessfully extends CompanyStates{

  CompanyResponse response;
  LoadedSuccessfully(this.response);

}

class LoadedErrorState extends CompanyStates{
  dynamic error;
  LoadedErrorState(this.error);
}

