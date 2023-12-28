class CartResponse {
  bool? status;
  List<Data>? data;
  String? message;

  CartResponse({this.status, this.data, this.message});

  CartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? orderId;
  int? clientId;
  int? companyId;
  int? deliveryTypeId;
  String? promoCodeId;
  String? clientLocationId;
  String? invoiceId;
  String? deletedAt;
  Order? order;
  Company? company;

  Data(
      {this.orderId,
        this.clientId,
        this.companyId,
        this.deliveryTypeId,
        this.promoCodeId,
        this.clientLocationId,
        this.invoiceId,
        this.deletedAt,
        this.order,
        this.company});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    clientId = json['client_id'];
    companyId = json['company_id'];
    deliveryTypeId = json['delivery_type_id'];
    promoCodeId = json['promo_code_id'];
    clientLocationId = json['client_location_id'];
    invoiceId = json['invoice_id'];
    deletedAt = json['deleted_at'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['client_id'] = this.clientId;
    data['company_id'] = this.companyId;
    data['delivery_type_id'] = this.deliveryTypeId;
    data['promo_code_id'] = this.promoCodeId;
    data['client_location_id'] = this.clientLocationId;
    data['invoice_id'] = this.invoiceId;
    data['deleted_at'] = this.deletedAt;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? role;
  String? status;
  String? specialInstructions;
  String? comment;
  String? pickupDate;
  String? deliveryDate;
  String? actualPickupStartDateTime;
  String? actualPickupEndDateTime;
  String? actualDeliveryStartDateTime;
  String? actualDeliveryEndDateTime;
  String? driversManagerId;
  String? deliveryDriverAssignedToTransportationPeriodId;
  String? pickupDriverAssignedToTransportationPeriodId;
  String? price;
  String? type;
  String? discountValue;
  String? discountValueType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Items>? items;

  Order(
      {this.id,
        this.role,
        this.status,
        this.specialInstructions,
        this.comment,
        this.pickupDate,
        this.deliveryDate,
        this.actualPickupStartDateTime,
        this.actualPickupEndDateTime,
        this.actualDeliveryStartDateTime,
        this.actualDeliveryEndDateTime,
        this.driversManagerId,
        this.deliveryDriverAssignedToTransportationPeriodId,
        this.pickupDriverAssignedToTransportationPeriodId,
        this.price,
        this.type,
        this.discountValue,
        this.discountValueType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.items});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    status = json['status'];
    specialInstructions = json['special_instructions'];
    comment = json['comment'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    actualPickupStartDateTime = json['actual_pickup_start_date_time'];
    actualPickupEndDateTime = json['actual_pickup_end_date_time'];
    actualDeliveryStartDateTime = json['actual_delivery_start_date_time'];
    actualDeliveryEndDateTime = json['actual_delivery_end_date_time'];
    driversManagerId = json['drivers_manager_id'];
    deliveryDriverAssignedToTransportationPeriodId =
    json['delivery_driver_assigned_to_transportation_period_id'];
    pickupDriverAssignedToTransportationPeriodId =
    json['pickup_driver_assigned_to_transportation_period_id'];
    price = json['price'];
    type = json['type'];
    discountValue = json['discount_value'];
    discountValueType = json['discount_value_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['status'] = this.status;
    data['special_instructions'] = this.specialInstructions;
    data['comment'] = this.comment;
    data['pickup_date'] = this.pickupDate;
    data['delivery_date'] = this.deliveryDate;
    data['actual_pickup_start_date_time'] = this.actualPickupStartDateTime;
    data['actual_pickup_end_date_time'] = this.actualPickupEndDateTime;
    data['actual_delivery_start_date_time'] = this.actualDeliveryStartDateTime;
    data['actual_delivery_end_date_time'] = this.actualDeliveryEndDateTime;
    data['drivers_manager_id'] = this.driversManagerId;
    data['delivery_driver_assigned_to_transportation_period_id'] =
        this.deliveryDriverAssignedToTransportationPeriodId;
    data['pickup_driver_assigned_to_transportation_period_id'] =
        this.pickupDriverAssignedToTransportationPeriodId;
    data['price'] = this.price;
    data['type'] = this.type;
    data['discount_value'] = this.discountValue;
    data['discount_value_type'] = this.discountValueType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? orderId;
  String? name;
  int? quantity;
  String? price;
  int? productOptionId;
  String? deletedAt;

  Items(
      {this.id,
        this.orderId,
        this.name,
        this.quantity,
        this.price,
        this.productOptionId,
        this.deletedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    productOptionId = json['product_option_id'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['product_option_id'] = this.productOptionId;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Company {
  int? userId;
  String? nameAr;
  String? nameEn;
  int? ordersPerHour;
  String? logoPath;
  String? deletedAt;
  int? countryId;
  User? user;

  Company(
      {this.userId,
        this.nameAr,
        this.nameEn,
        this.ordersPerHour,
        this.logoPath,
        this.deletedAt,
        this.countryId,
        this.user});

  Company.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    ordersPerHour = json['orders_per_hour'];
    logoPath = json['logo_path'];
    deletedAt = json['deleted_at'];
    countryId = json['country_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['orders_per_hour'] = this.ordersPerHour;
    data['logo_path'] = this.logoPath;
    data['deleted_at'] = this.deletedAt;
    data['country_id'] = this.countryId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.role,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
