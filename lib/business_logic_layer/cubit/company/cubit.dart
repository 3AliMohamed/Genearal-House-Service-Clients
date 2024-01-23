import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/states.dart';
import 'package:general_house_service_clients/data_layer/repository/company_repository.dart';

import '../../../data_layer/models/responses/company_response.dart';

class CompanyCubit extends Cubit<CompanyStates>{
  CompanyCubit() : super(InitialState());

  static CompanyCubit get(context) => BlocProvider.of(context);
  List<Categories>categories=[];
  void getCompany(int ? categoryId)
  async{
    emit(LoadingState());
    try{
      final response = await CompanyRepository.getCompany(categoryId: categoryId);
      categories=List.from(response.data![0].categories ?? []);
      emit(LoadedSuccessfully(response));
    } catch(error){
      LoadedErrorState(error);
    }
  }

}