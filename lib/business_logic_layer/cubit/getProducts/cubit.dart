import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/getProducts/states.dart';
import 'package:general_house_service_clients/data_layer/repository/product_repository.dart';

import '../../../data_layer/models/product_reposnse.dart';

class ProductCubit extends Cubit<ProductStates>
{
  ProductCubit() : super(InitialState());
  Map<String, List<Options>> optionsMap = {};

  static ProductCubit get(context) => BlocProvider.of(context);


  void getProduct(int companyId,int categoryId)
  async{
      emit(LoadingState());
      try{
        final products =await ProductRepository.getProduct(categoryId, companyId);
        for (int i = 0; i < products.length; i++) {
          String productId = products[i].id.toString();

          // Check if the product ID already exists in the map
          if (optionsMap.containsKey(productId)) {
            // Append options to the existing list of options for the product ID
            optionsMap[productId]!.addAll(products[i].options!);
          } else {
            // Create a new list of options for the product ID
            optionsMap[productId] = List.from(products[i].options!);
          }
        }
        optionsMap.forEach((key, value) {
          print('Product ID: $key');
          print('Options:');

          value.forEach((option) {
            print('Option ID: ${option.id}, Name (EN): ${option.nameEn}');
            // Print other option details as needed
          });
          print('-----------------');
        });

        // log("options"+ optionsList.toString());
        emit(LoadedSuccessfullyState(products));
      }catch(error)
    {
      emit(LoadedErrorState(error));
    }
  }

}