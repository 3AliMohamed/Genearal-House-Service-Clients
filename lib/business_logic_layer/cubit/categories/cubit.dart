import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/category_repository.dart';
import 'package:general_house_service_clients/data_layer/repository/category_with_parent_repository.dart';

class CategoryCubit extends Cubit<CategoryStates>
{
   CategoryCubit() :super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);
  List<String> arabicNamesOfCategories=[];
  List<String> englishNamesOfCategories=[];
  List<String> imagesOfCategory=[];
  // List<Map<String,dynamic>> categories=[];
  void getCategory({int? parentId,int? companyId})
  {
    // if(id!=null)
    // {
        log("inside if :"+companyId.toString());
        CategoryWithParentRepository.getCategory(parentId:parentId,companyId:companyId).then((responseWithParent) {
          // responseWithParent.data?.categories?.map((catWithParent) => categories.add(catWithParent as Map<String, dynamic>));
          emit(CategoryWithParentLoadedSuccessState(responseWithParent));
        }).catchError((error){
          emit(CategoryWithParentLoadErrorState(error));
        });
    // }
    // else
    // {
    //   CategoryRepository.getCategory().then((response){
    //   response.data?.categories?.map((cat) => categories.add(cat as Map<String, dynamic>));
    //   for(int i=0 ;i<response.data!.categories!.length;i++)
    //     {
    //       arabicNamesOfCategories.add(response.data!.categories![i].nameAr.toString());
    //       englishNamesOfCategories.add(response.data!.categories![i].nameEn.toString());
    //       imagesOfCategory.add(ApiUrls().apiUrl+response.data!.categories![i].imgPath.toString());
        }
      // emit(CategoryLoadedSuccessState(response));
    // }).catchError((error){
    //   emit(CategoryLoadErrorState(error));
    // });
  // }
  // }

}