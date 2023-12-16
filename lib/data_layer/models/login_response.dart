class LoginResponse {
  bool? status;
  Data? data;
  String? message;

  LoginResponse({this.status, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  int? age;
  String? address;
  String? gender;
  String? providerName;
  String? providerId;
  String? accessToken;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? avatar;
  int? countryId;
  String? token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.age,
        this.address,
        this.gender,
        this.providerName,
        this.providerId,
        this.accessToken,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.avatar,
        this.countryId,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    age = json['age'];
    address = json['address'];
    gender = json['gender'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    accessToken = json['access_token'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    avatar = json['avatar'];
    countryId = json['country_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['age'] = this.age;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['provider_name'] = this.providerName;
    data['provider_id'] = this.providerId;
    data['access_token'] = this.accessToken;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['avatar'] = this.avatar;
    data['country_id'] = this.countryId;
    data['token'] = this.token;
    return data;
  }
}
