import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/checkOut/states.dart';
import 'package:general_house_service_clients/data_layer/repository/checkOut_repository.dart';
import 'package:get/get.dart';

import '../../../data_layer/models/requests/checkOut_order.dart';

class CheckOutCubit extends Cubit<CheckOutStates>{
  CheckOutCubit (): super(InitialState());
  List<OrderOptions> orderOptions=[];
  late CheckOutOrder checkOutOrder;
static CheckOutCubit get(context)=> BlocProvider.of(context);
  void setOrder(Map<String, List<dynamic>> product)
  async{
    log("insid cubit");
    log("lp"+product.toString());
    for (int i = 0; i < product['quantity']!.length; i++) {

      int? optionId = int.tryParse(product['optionsIds']![i].toString());
      int? quantity = int.tryParse(product['quantity']![i].toString());

      if (optionId != null && quantity != null) {
        OrderOptions newOption = OrderOptions(
          productOptionId: optionId,
          quantity: quantity,
        );
        orderOptions.add(newOption);
      } else {
        log("error");
        // Handle parsing errors if necessary
      }
    }
    log("o2");
    log(orderOptions.length.toString());
    // int? orderId= int.tryParse(product['orderId']![0]);
    log("bbbb"); int? orderId = int.tryParse(product['orderId']![0].toString());
    String? specialInstructions = product['specialInstruction']![0].toString();
    String? comment = product['comment']![0].toString();
    int? companyId = int.tryParse(product['companyId']![0].toString());
    int? clientId=int.tryParse(product['clientId']![0]);
    int? locationId=int.tryParse(product['locationId']![0]);
    int? deliveryTypeId=int.tryParse(product['deliveryTypeId']![0]);
// ... other properties

    log('orderId: $orderId');
    log('specialInstructions: $specialInstructions');
    log('comment: $comment');
    log("clientId :"+clientId.toString());
    log("delvery :"+deliveryTypeId.toString());
    log("location :"+locationId.toString());
// ... log other properties

    if (orderId != null &&
        specialInstructions != null &&
        comment != null &&
        companyId != null &&
        clientId != null &&
        deliveryTypeId != null &&
        locationId != null) {

      // Construct the CheckOutOrder object and assign it to the class-level variable
      CheckOutOrder checkOutOrder = CheckOutOrder(
        orderOptions: orderOptions,
        orderId: orderId,
        specialInstructions: specialInstructions,
        comment: comment,
        companyId: companyId,
        clientId: clientId,
        clientLocationId: locationId,
        deliveryTypeId: deliveryTypeId,
        // ... other properties
      );
      CheckOutRepository.setOrder(checkOutOrder);
      // Now check if the checkOutOrder object has the expected values
      log(checkOutOrder.comment.toString());
      log('Constructed CheckOutOrder object: ${checkOutOrder.toJson()}');
    } else {
      log('One or more properties have null values, unable to construct CheckOutOrder');
    }


    }
  num calculateTotalOrderPrice(List<dynamic> orderPrices) {
    if (orderPrices.isEmpty) {
      return 0.0; // Return 0 if the list is empty
    }

    // Use fold to calculate the sum of the order prices
    return orderPrices.fold(0.0, (num sum, dynamic orderPrice) {
      if (orderPrice is num) {
        return sum + orderPrice.toDouble(); // Add the order price to the sum
      } else {
        // Handle the case where an element in the list is not a number
        // You can choose to ignore it, throw an exception, or handle it in a specific way
        return sum;
      }
    });
  }



}