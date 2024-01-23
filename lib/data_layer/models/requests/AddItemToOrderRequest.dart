
class AddItemToOrderRequest {

  List<AddItemToOrderRequestItem> addItemToOrderRequestItems;
  int companyId;

  AddItemToOrderRequest({required this.addItemToOrderRequestItems, required this.companyId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = this.companyId;

    if (this.addItemToOrderRequestItems != null) {
    data['items'] = this.addItemToOrderRequestItems.map((e) => e.toJson()).toList();
    }

    return data;
  }

  void reset(){
    addItemToOrderRequestItems.clear();
    companyId=0;
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


