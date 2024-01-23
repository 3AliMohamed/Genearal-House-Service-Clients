import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/register/states.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/register_repository.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  bool passwordVisible_signup=false;
  bool passwordVisibleTwo_signup=false;
  String gender='';


  static RegisterCubit get(context) => BlocProvider.of(context);


  Future<void> register(String email, String password, String name,
      String phone,  String gender,
      String country_id,)
  async {
    Map<String,dynamic> response= await RegisterRepository.register(email, password, name, phone,  gender, country_id);
    if(response['status']==true){
      // log(" ksdgfjg");
      emit(RegisterSuccessState());
    }
    else {
      // log("ali");
      emit(RegisterErrorState(response['message'].toString()));
      // log("error"+response['message'].toString());
    }


  }
  void changePasswordVisibilitySingUp()
  {
    passwordVisible_signup=!passwordVisible_signup;
    emit(ChangePasswordVisibiltyStateSingUp());
  }
  void changeConfirmPasswordVisibilitySingUp()
  {
    passwordVisibleTwo_signup=!passwordVisibleTwo_signup;
    emit(ChangeConfirmPasswordVisibiltyStateSingUp());
  }

  void changeGender(String value){
    gender=value;
    emit(ChangeGenderState());

  }

}