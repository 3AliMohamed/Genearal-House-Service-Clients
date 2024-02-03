class CompanyResponse {
  bool? status;
  List<Data>? data;
  String? message;

  CompanyResponse({this.status, this.data, this.message});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? companyId;
  int? categoryId;
  String? nameAr;
  String? nameEn;
  String? coverPath;
  int? ordersPerHour;
  String? logoPath;
  List<DeliveryTypes>? deliveryTypes;
  int? rateCount;
  int? avrageRate;
  String? createdAt;
  List<Categories>? categories;

  Data(
      {this.id,
        this.companyId,
        this.categoryId,
        this.nameAr,
        this.nameEn,
        this.coverPath,
        this.ordersPerHour,
        this.logoPath,
        this.deliveryTypes,
        this.rateCount,
        this.avrageRate,
        this.createdAt,
        this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    categoryId = json['category_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    coverPath = json['cover_path'];
    ordersPerHour = json['orders_per_hour'];
    logoPath = json['logo_path'];
    if (json['delivery_types'] != null) {
      deliveryTypes = <DeliveryTypes>[];
      json['delivery_types'].forEach((v) {
        deliveryTypes!.add(new DeliveryTypes.fromJson(v));
      });
    }
    rateCount = json['rate_count'];
    avrageRate = json['avrage_rate'];
    createdAt = json['created_at'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['category_id'] = this.categoryId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['cover_path'] = this.coverPath;
    data['orders_per_hour'] = this.ordersPerHour;
    data['logo_path'] = this.logoPath;
    if (this.deliveryTypes != null) {
      data['delivery_types'] =
          this.deliveryTypes!.map((v) => v.toJson()).toList();
    }
    data['rate_count'] = this.rateCount;
    data['avrage_rate'] = this.avrageRate;
    data['created_at'] = this.createdAt;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryTypes {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  int? afterHours;
  num? addedValue;
  String? addedValueType;

  DeliveryTypes(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.descriptionAr,
        this.descriptionEn,
        this.afterHours,
        this.addedValue,
        this.addedValueType});

  DeliveryTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    afterHours = json['after_hours'];
    addedValue = json['added_value'];
    addedValueType = json['added_value_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['after_hours'] = this.afterHours;
    data['added_value'] = this.addedValue;
    data['added_value_type'] = this.addedValueType;
    return data;
  }
}

class Categories {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;

  Categories({this.id, this.nameAr, this.nameEn, this.imgPath});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    return data;
  }
}
