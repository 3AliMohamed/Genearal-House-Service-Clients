class ProfileResponse {
  bool? status;
  List<ProfileData>? data;
  String? message;

  ProfileResponse({this.status, this.data, this.message});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProfileData>[];
      json['data'].forEach((v) {
        data!.add(new ProfileData.fromJson(v));
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

class ProfileData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? age;
  String? address;
  String? gender;
  int? active;
  String? avatar;
  int? countryId;
  List<ClientLocation>? clientLocation;

  ProfileData(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.age,
        this.address,
        this.gender,
        this.active,
        this.avatar,
        this.countryId,
        this.clientLocation});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    address = json['address'];
    gender = json['gender'];
    active = json['active'];
    avatar = json['avatar'];
    countryId = json['country_id'];
    if (json['client_location'] != null) {
      clientLocation = <ClientLocation>[];
      json['client_location'].forEach((v) {
        clientLocation!.add(new ClientLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['age'] = this.age;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['active'] = this.active;
    data['avatar'] = this.avatar;
    data['country_id'] = this.countryId;
    if (this.clientLocation != null) {
      data['client_location'] =
          this.clientLocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientLocation {
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

  ClientLocation(
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

  ClientLocation.fromJson(Map<String, dynamic> json) {
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
