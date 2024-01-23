class AddressResponse {
  bool? status;
  List<Data>? data;
  String? message;

  AddressResponse({this.status, this.data, this.message});

  AddressResponse.fromJson(Map<String, dynamic> json) {
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
  int? clientId;
  String? lat;
  String? long;
  String? phoneNumber;
  String? telephone;
  String? locationType;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? additionalInstructions;
  String? detailedAddress;

  Data(
      {this.id,
        this.clientId,
        this.lat,
        this.long,
        this.phoneNumber,
        this.telephone,
        this.locationType,
        this.street,
        this.building,
        this.floor,
        this.apartment,
        this.additionalInstructions,
        this.detailedAddress});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    lat = json['lat'];
    long = json['long'];
    phoneNumber = json['phone_number'];
    telephone = json['telephone'];
    locationType = json['location_type'];
    street = json['street'];
    building = json['building'];
    floor = json['floor'];
    apartment = json['apartment'];
    additionalInstructions = json['additional_instructions'];
    detailedAddress = json['detailed_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['phone_number'] = this.phoneNumber;
    data['telephone'] = this.telephone;
    data['location_type'] = this.locationType;
    data['street'] = this.street;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['apartment'] = this.apartment;
    data['additional_instructions'] = this.additionalInstructions;
    data['detailed_address'] = this.detailedAddress;
    return data;
  }
}
