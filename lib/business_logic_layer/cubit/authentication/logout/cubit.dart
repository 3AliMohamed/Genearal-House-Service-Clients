import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/logout/states.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/logout_respository.dart';

class LogoutCubit extends Cubit<LogOutStates>
{
  LogoutCubit(): super(InitialState());

  static LogoutCubit get(context) => BlocProvider.of(context);

  Future<void> logOut()
  async{

      bool isLogedOut= await LogOutRepository.logOut();
      isLogedOut? emit(SuccessState()) : emit(FailedState());

  }
}