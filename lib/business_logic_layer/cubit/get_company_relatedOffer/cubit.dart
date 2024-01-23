import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/get_company_relatedOffer/states.dart';

class GetCompanyCubit extends Cubit<GetCompanyState>
{
  GetCompanyCubit() : super(GetCompanyInitialState());

  GetCompanyCubit get(context)=> BlocProvider.of(context);


}