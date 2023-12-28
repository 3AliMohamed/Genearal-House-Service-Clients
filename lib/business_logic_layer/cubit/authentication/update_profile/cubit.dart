import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/update_profile/states.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/update_prodile_repository.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState>
{
  UpdateProfileCubit () : super (InitialState());

  static UpdateProfileCubit get(context) => BlocProvider.of(context);
  // static ProfileCubit get(context) => BlocProvider.of(context);

   void updateProfile(String name, String phone, String gender,
      String email, String age, String country, String address, String password,
      )
  async{
      final bool response=await UpdateProfileRepository.updateProfile(name, phone, gender, email, age, country, address, password);
       if(response ==true)
         {
           emit(UpdatedSuccessState());
         }
       else{
         emit(UpdatedFailedState());
       }

  }

}