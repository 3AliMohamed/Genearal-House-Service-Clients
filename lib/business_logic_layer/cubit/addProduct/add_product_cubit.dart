import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/data_layer/repository/add_order_repository.dart';

import '../../../data_layer/models/requests/AddItemToOrderRequest.dart';
import 'add_product_states.dart';

class AddProductCubit extends Cubit<AddProductStates>{
  //Singleton instance
  // static final AddProductCubit _instance = AddProductCubit._internal();
  //
  // factory AddProductCubit() {
  // return _instance;
  // }
  //
  // AddProductCubit._internal() : super(InitialState());
AddProductCubit() : super(AddProductInitialState());
  static AddProductCubit get(context) => BlocProvider.of(context);

  int quantity=0;
  late AddItemToOrderRequest chosenOptions;
  List <AddItemToOrderRequestItem> chosenItem=[];
  // Map<String,dynamic> opt={};
  void incrementQuantity(){
    quantity++;
    emit(IncrementQuantity());
  }

  void decrementQuantity(){
    if(quantity>0)
    {
      quantity--;
    }
    else
    {
      quantity=0;
    }
    emit(DecrementQuantity());
  }

  void addOption(int? id, int? quantity){
    AddItemToOrderRequestItem newOption = AddItemToOrderRequestItem(productOptionId: id, quantity: quantity);
    chosenItem.add(newOption);
    for(int i=0;i<chosenItem.length;i++){
      log("len :"+chosenItem.length.toString());
      log('chosen item:'+chosenItem[i].quantity.toString());

    // chosenItem.map((e) => log(e.quantity.toString()));
    }
    this.quantity=0;
    // this.chosenItem.clear();
  }
  void addOrder(int? companyId)
  async{
    emit(PlacingOrderState());
    AddItemToOrderRequest chosenOptions=AddItemToOrderRequest(addItemToOrderRequestItems:chosenItem,companyId:companyId!);
    log(chosenOptions.companyId.toString());
    for(int i=0;i<chosenOptions.addItemToOrderRequestItems.length;i++){
      log("product option  :"+chosenOptions.addItemToOrderRequestItems[i].productOptionId.toString());
      log('quantity :'+chosenOptions.addItemToOrderRequestItems[i].quantity.toString());
      // chosenItem.map((e) => log(e.quantity.toString()));
    }
    // log(chosenOptions.addItemToOrderRequestItems.length.toString());
    // log("object all"+chosenOptions[0].addItemToOrderRequestItems[3].quantity.toString());
    // log("len all"+newObj.addItemToOrderRequestItems.length.toString());

    bool isSet=await AddProductRepository.setOrder(chosenOptions);
    isSet? emit(PlacedSuccessfullyState()) : emit(ErrorState());
    chosenOptions.reset();

  }

}