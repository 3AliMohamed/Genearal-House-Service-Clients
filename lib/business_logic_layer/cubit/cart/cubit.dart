import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/states.dart';

class CartCubit extends Cubit<CartStates>
{
  CartCubit () : super(InitialState());
  CartCubit get(context) => BlocProvider.of(context);



}