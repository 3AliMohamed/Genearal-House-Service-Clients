import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/promo_code/states.dart';
import 'package:general_house_service_clients/data_layer/repository/promo_code_repository.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';

class PromoCodeCubit extends Cubit<PromoCodeStates>
{
  PromoCodeCubit () : super(PromoCodeInitialState());

  static PromoCodeCubit get(context) => BlocProvider.of(context);
  num discount=0;
  num totalOrderPrice=100;
  void tryPromoCode(String orderId, String inputPromoCode, String companyId,num totalPrice)
  async{
    log('order ID '+ orderId.toString());
    log('company id '+ companyId.toString());
      emit(PromoCodeLoadingState());
      dynamic promoCode= await PromoCodeRepository.tryPromoCode(orderId, inputPromoCode, companyId);
      if(promoCode.status==true)
        {
            if(promoCode.data.valueType=='constant'){
              discount=promoCode.data.value;
              emit(PromoCodeSuccessState());
            }
            else{

                discount = (totalPrice * promoCode.data.value!) / 100.0;
                emit(PromoCodeSuccessState());
            }
        }
      else{
        emit(PromoCodeErrorState());
        showToast(promoCode.message.toString());
      }
  }
  void calculateTotalOrderPrice(num total,{ num vat=0,num deliveryFees=0})
  {
    totalOrderPrice=total+vat+deliveryFees;
    totalOrderPrice-=discount;
  }
}