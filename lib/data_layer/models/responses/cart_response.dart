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
  String? clientId;
  Order? order;
  Company? company;

  Data({this.orderId, this.clientId, this.order, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    clientId = json['client_id'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['client_id'] = this.clientId;
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
  List<Items>? items;

  Order({this.id, this.role, this.status, this.items});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    status = json['status'];
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
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  Product? product;

  Items({this.product});

  Items.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  ProductOption? productOption;

  Product(
      {this.id, this.nameAr, this.nameEn, this.imgPath, this.productOption});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    productOption = json['product_option'] != null
        ? new ProductOption.fromJson(json['product_option'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    if (this.productOption != null) {
      data['product_option'] = this.productOption!.toJson();
    }
    return data;
  }
}

class ProductOption {
  int? id;
  int? productId;
  String? nameAr;
  String? nameEn;
  String? priceUnitAr;
  String? priceUnitEn;
  int? price;
  int? quantity;

  ProductOption(
      {this.id,
        this.productId,
        this.nameAr,
        this.nameEn,
        this.priceUnitAr,
        this.priceUnitEn,
        this.price,
        this.quantity});

  ProductOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    priceUnitAr = json['price_unit_ar'];
    priceUnitEn = json['price_unit_en'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price_unit_ar'] = this.priceUnitAr;
    data['price_unit_en'] = this.priceUnitEn;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Company {
  int? userId;
  String? nameAr;
  String? nameEn;
  String? logoPath;
  User? user;

  Company({this.userId, this.nameAr, this.nameEn, this.logoPath, this.user});

  Company.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    logoPath = json['logo_path'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['logo_path'] = this.logoPath;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? phone;

  User({this.id, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    return data;
  }
}
