import 'package:general_house_service_clients/data_layer/models/responses/cart_response.dart';

class CheckOutOrder{
  late List<OrderOptions> orderOptions;

   int? orderId;
   String? specialInstructions;
   String? comment;
   int? companyId;
   int? deliveryTypeId;
   int? clientLocationId;
   int? clientId;

  CheckOutOrder({required this.orderOptions, required this.orderId,required this.specialInstructions,
  required this.comment, required this.companyId, required this.deliveryTypeId, required this.clientLocationId,
    required this.clientId
  });

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {};
    data['order_id']=this.orderId;
    data['special_instructions']=this.specialInstructions;
    data['comment']=this.comment;
    data['company_id']=this.companyId;
    data['delivery_type_id']=this.deliveryTypeId;
    data['client_location_id']=this.clientLocationId;
    data['client_id']=this.clientId;

    if(orderOptions !=null)
      {
        data['items']=this.orderOptions.map((e) => e.toJson()).toList();
      }
    return data ;
  }
}

class OrderOptions{

  int? productOptionId;
  int? quantity;
  OrderOptions({required this.productOptionId,required this.quantity});

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {} ;
    data['product_option_id']=this.productOptionId;
    data['quantity']= this.quantity;

    return data;
  }

}