
class AddItemToOrderRequest {

  List<AddItemToOrderRequestItem> addItemToOrderRequestItems;
  int? companyId;
  int? deliveryTypeId;
  AddItemToOrderRequest({required this.addItemToOrderRequestItems, required this.companyId,required this.deliveryTypeId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = this.companyId;
    data['delivery_type_id'] = this.deliveryTypeId;

    if (this.addItemToOrderRequestItems != null) {
    data['items'] = this.addItemToOrderRequestItems.map((e) => e.toJson()).toList();
    }

    return data;
  }

  void reset(){
    addItemToOrderRequestItems.clear();
    companyId=null;
    deliveryTypeId=null;
  }
}



class AddItemToOrderRequestItem {

  int? productOptionId;
  int? quantity;

  AddItemToOrderRequestItem({required this.productOptionId,required this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Assign class variables to the 'data' map keys
    data['product_option_id'] = this.productOptionId;
    data['quantity'] = this.quantity;

    return data;
  }


}


