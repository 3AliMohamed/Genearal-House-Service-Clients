class PromoCodeResponse {
  bool? status;
  Data? data;
  String? message;

  PromoCodeResponse({this.status, this.data, this.message});

  PromoCodeResponse.fromJson(Map<String, dynamic> json) {
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
  String? code;
  int? value;
  String? valueType;
  String? type;
  String? from;
  String? to;
  int? active;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.code,
        this.value,
        this.valueType,
        this.type,
        this.from,
        this.to,
        this.active,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    valueType = json['value_type'];
    type = json['type'];
    from = json['from'];
    to = json['to'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['value_type'] = this.valueType;
    data['type'] = this.type;
    data['from'] = this.from;
    data['to'] = this.to;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
