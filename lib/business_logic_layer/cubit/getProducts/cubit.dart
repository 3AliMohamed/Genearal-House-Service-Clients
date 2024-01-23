import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/getProducts/states.dart';
import 'package:general_house_service_clients/data_layer/repository/product_repository.dart';

import '../../../data_layer/models/responses/product_reposnse.dart';

class ProductCubit extends Cubit<ProductStates>
{
  ProductCubit() : super(InitialState());
  Map<String, List<Options>> optionsMap = {};
  List<ProductData>? products=[];
  double? increasedValue;
  num? percentage=0;
  static ProductCubit get(context) => BlocProvider.of(context);


  void getProduct(int companyId,int categoryId)
  async{
      emit(LoadingState());
      try{
         products =await ProductRepository.getProduct(categoryId, companyId);
         if (products != null && products!.isNotEmpty) {
           for (int i = 0; i < products!.length; i++) {
             String productId = products![i].id.toString();

             // Check if the product ID already exists in the map
             if (optionsMap.containsKey(productId)) {
               // Append options to the existing list of options for the product ID
               optionsMap[productId]!.addAll(products![i].options!);
             } else {
               // Create a new list of options for the product ID
               optionsMap[productId] = List.from(products![i].options!);
             }
           }
           // log("options"+ optionsList.toString());
           emit(LoadedSuccessfullyState());
         }else {
           // Handle case where products is null or empty
           emit(LoadedErrorState("No products available"));
         }
      }catch(error)
    {
      emit(LoadedErrorState(error));
    }
  }

  void setPercentage(num value)
  {
    percentage=value;
    emit(UpdatePercentageSuccess());
  }
  void calculateIncreasedValue(int value)
  {
     increasedValue = (value * percentage!) / 100.0;
     // emit(UpdatePercentageSuccess());
  }
  void clearProducts() {
    products = [];
  }
}