import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/login_cubit/states.dart';

import '../../../../data_layer/repository/authentication/login_repository.dart';


class LogInCubit extends Cubit<LogInStates>
{
  LogInRepository loginRepository;
  LogInCubit(this.loginRepository) : super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  bool passwordVisible=false;


  void changePasswordVissibilty()
  {
    passwordVisible=!passwordVisible;
    emit(ChangePassVisibiltyState());
  }
  void login(String email, String password)
  async{
    try{
      final response = await loginRepository.login(email, password);
      emit(LoginSuccessState());
      log(response.toString());
    }
    catch(e){
      emit(LoginErrorState(e.toString()));
    }

    // loginRepository.login(email, password).then((response){
    //   // log("reponse :" + response.toString());
    //   emit(LoginSuccessState());
    // }).catchError((error){
    //
    //   log("error : "+error.toString());
    //   emit(LoginErrorState(error.toString()));
    // });
  }





}