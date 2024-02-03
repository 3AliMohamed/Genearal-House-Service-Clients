import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/delete_item_from_cart/states.dart';
import 'package:general_house_service_clients/data_layer/repository/delete_item_from_cart_repository.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

class DeleteItemFromCartCubit extends Cubit<DeleteItemFromCartStates> {
  DeleteItemFromCartCubit() :super(InitialState());

  static DeleteItemFromCartCubit get(context) => BlocProvider.of(context);
}
