import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/category_repository.dart';

import '../../../data_layer/models/dtos/Category.dart';

class CategoryCubit extends Cubit<CategoryStates>
{
   CategoryCubit() :super(InitialState());


  static CategoryCubit get(context) => BlocProvider.of(context);

  // Map<int,List<Category>> categoriesIdsWithSubCategories = <int,List<Category>>{};
  void getCategory({int? parentId,int? companyId})
  async{

        emit(LoadingState());
        try {
          final response = await CategoryRepository.getCategory(
            parentId: parentId?.toInt(),
            companyId: companyId,
          );
          emit(LoadedSuccessfullyState(response!));
        } catch (error) {
          emit(LoadingErrorState(error));
        }

  }
}
