class ProductResponse {
  bool? status;
  List<ProductData>? data;
  String? message;

  ProductResponse({this.status, this.data, this.message});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
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

class ProductData {
  int? id;
  int? categoryId;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? active;
  List<Options>? options;

  ProductData(
      {this.id,
        this.categoryId,
        this.nameAr,
        this.nameEn,
        this.imgPath,
        this.companyId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.active,
        this.options});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    active = json['active'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['active'] = this.active;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  int? productId;
  String? nameAr;
  String? nameEn;
  String? priceUnitAr;
  String? priceUnitEn;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? active;

  Options(
      {this.id,
        this.productId,
        this.nameAr,
        this.nameEn,
        this.priceUnitAr,
        this.priceUnitEn,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.active});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    priceUnitAr = json['price_unit_ar'];
    priceUnitEn = json['price_unit_en'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    active = json['active'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['active'] = this.active;
    return data;
  }
}
