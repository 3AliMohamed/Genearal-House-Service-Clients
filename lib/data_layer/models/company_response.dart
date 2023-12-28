class CompanyResponse {
  Status? status;
  dynamic data;
  String? message;

  CompanyResponse({this.status, this.data, this.message});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Status {
  int? newOne;
  int? aj;
  int? updated;
  int? companyNameShownToClients;
  int? i5test;

  Status(
      {this.newOne,
        this.aj,
        this.updated,
        this.companyNameShownToClients,
        this.i5test});

  Status.fromJson(Map<String, dynamic> json) {
    newOne = json['new one'];
    aj = json['Aj'];
    updated = json['updated'];
    companyNameShownToClients = json['Company name shown to clients'];
    i5test = json['5test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new one'] = this.newOne;
    data['Aj'] = this.aj;
    data['updated'] = this.updated;
    data['Company name shown to clients'] = this.companyNameShownToClients;
    data['5test'] = this.i5test;
    return data;
  }
}

class CompanyData {
  int? id;
  int? companyId;
  int? categoryId;
  String? createdAt;
  int? userId;
  String? nameAr;
  int? countryId;
  int? ordersPerHour;
  String? logoPath;
  int? rateCount;
  int? avrageRate;

  CompanyData(
      {this.id,
        this.companyId,
        this.categoryId,
        this.createdAt,
        this.userId,
        this.nameAr,
        this.countryId,
        this.ordersPerHour,
        this.logoPath,
        this.rateCount,
        this.avrageRate});

  CompanyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    nameAr = json['name_ar'];
    countryId = json['country_id'];
    ordersPerHour = json['orders_per_hour'];
    logoPath = json['logo_path'];
    rateCount = json['rate_count'];
    avrageRate = json['avrage_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    data['name_ar'] = this.nameAr;
    data['country_id'] = this.countryId;
    data['orders_per_hour'] = this.ordersPerHour;
    data['logo_path'] = this.logoPath;
    data['rate_count'] = this.rateCount;
    data['avrage_rate'] = this.avrageRate;
    return data;
  }
}
