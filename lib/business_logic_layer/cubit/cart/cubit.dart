import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/states.dart';
import 'package:general_house_service_clients/data_layer/repository/cart_repository.dart';

import '../../../data_layer/models/responses/cart_response.dart';

class CartCubit extends Cubit<CartStates>
{
  CartCubit () : super(InitialState());
 static CartCubit get(context) => BlocProvider.of(context);

 int comulativeTotolPrice=0;
 List<Data>? responseData;
  void calculateTotal(int value)
 {
   comulativeTotolPrice+=value;
   emit(CalculatedState());
 }
 void incrementQuantity(int dataIndex ,int index){
   responseData![dataIndex].order!.items![index].product!.productOption!.quantity =
   (responseData![dataIndex].order!.items![index].product!.productOption!.quantity! + 1);
   emit(IncrementState());
 }

 void decrementQuantity(int dataIndex ,int index){
    if(responseData![dataIndex].order!.items![index].product!.productOption!.quantity! >1)
      {
        responseData![dataIndex].order!.items![index].product!.productOption!.quantity =
        (responseData![dataIndex].order!.items![index].product!.productOption!.quantity! -1);
      }
   emit(DecrementState());
 }

 void reset()
 {
   responseData=[];
   emit(InitialState());
 }

  void getCart()
  async{
    emit(LoadingState());
    try{
        dynamic response= await CartRepository.getCart();
        responseData = response.data;
        emit(FetchDataSuccessState(response));

    }catch(error)
    {
      emit(FetchDataErrorState(error));
    }
  }

}