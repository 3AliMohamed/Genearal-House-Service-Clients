import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/states.dart';
import 'package:general_house_service_clients/data_layer/repository/company_repository.dart';

class CompanyCubit extends Cubit<CompanyStates>{
  CompanyCubit() : super(InitialState());

  static CompanyCubit get(context) => BlocProvider.of(context);

  void getCompany(int ? categoryId)
  async{
    emit(LoadingState());
    try{
      final response = await CompanyRepository.getCompany(categoryId: categoryId);
      emit(LoadedSuccessfully(response!));
    } catch(error){
      LoadedErrorState(error);
    }
  }

}