// class HomePageResponse {
//   bool? status;
//   HomePageData? data;
//   String? message;
//
//   HomePageResponse({this.status, this.data, this.message});
//
//   HomePageResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new HomePageData.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class HomePageData {
//   HomePage? homePage;
//   NavbarFooter? navbarFooter;
//
//   HomePageData({this.homePage, this.navbarFooter});
//
//   HomePageData.fromJson(Map<String, dynamic> json) {
//     homePage = json['home_page'] != null
//         ? new HomePage.fromJson(json['home_page'])
//         : null;
//     navbarFooter = json['navbar_footer'] != null
//         ? new NavbarFooter.fromJson(json['navbar_footer'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.homePage != null) {
//       data['home_page'] = this.homePage!.toJson();
//     }
//     if (this.navbarFooter != null) {
//       data['navbar_footer'] = this.navbarFooter!.toJson();
//     }
//     return data;
//   }
// }
//
// class HomePage {
//   int? id;
//   String? titleAr;
//   String? titleEn;
//   String? contentAr;
//   String? contentEn;
//   String? buttonTextAr;
//   String? buttonTextEn;
//   List<SliderImages>? sliderImages;
//
//   HomePage(
//       {this.id,
//         this.titleAr,
//         this.titleEn,
//         this.contentAr,
//         this.contentEn,
//         this.buttonTextAr,
//         this.buttonTextEn,
//         this.sliderImages});
//
//   HomePage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     titleAr = json['title_ar'];
//     titleEn = json['title_en'];
//     contentAr = json['content_ar'];
//     contentEn = json['content_en'];
//     buttonTextAr = json['button_text_ar'];
//     buttonTextEn = json['button_text_en'];
//     if (json['slider_images'] != null) {
//       sliderImages = <SliderImages>[];
//       json['slider_images'].forEach((v) {
//         sliderImages!.add(new SliderImages.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title_ar'] = this.titleAr;
//     data['title_en'] = this.titleEn;
//     data['content_ar'] = this.contentAr;
//     data['content_en'] = this.contentEn;
//     data['button_text_ar'] = this.buttonTextAr;
//     data['button_text_en'] = this.buttonTextEn;
//     if (this.sliderImages != null) {
//       data['slider_images'] =
//           this.sliderImages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SliderImages {
//   String? imgPath;
//
//   SliderImages({this.imgPath});
//
//   SliderImages.fromJson(Map<String, dynamic> json) {
//     imgPath = json['img_path'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['img_path'] = this.imgPath;
//     return data;
//   }
// }
//
//


class HomePageResponse {
  bool? status;
  HomePageData? data;
  String? message;

  HomePageResponse({this.status, this.data, this.message});

  HomePageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new HomePageData.fromJson(json['data']) : null;
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

class HomePageData {
  HomePage? homePage;
  List<Offers>? offers;

  HomePageData({this.homePage, this.offers});

  HomePageData.fromJson(Map<String, dynamic> json) {
    homePage = json['home_page'] != null
        ? new HomePage.fromJson(json['home_page'])
        : null;
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homePage != null) {
      data['home_page'] = this.homePage!.toJson();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomePage {
  int? id;
  String? titleAr;
  String? titleEn;
  String? contentAr;
  String? contentEn;
  String? buttonTextAr;
  String? buttonTextEn;
  List<SliderImages>? sliderImages;

  HomePage({this.id,
    this.titleAr,
    this.titleEn,
    this.contentAr,
    this.contentEn,
    this.buttonTextAr,
    this.buttonTextEn,
    this.sliderImages});

  HomePage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    contentAr = json['content_ar'];
    contentEn = json['content_en'];
    buttonTextAr = json['button_text_ar'];
    buttonTextEn = json['button_text_en'];
    if (json['slider_images'] != null) {
      sliderImages = <SliderImages>[];
      json['slider_images'].forEach((v) {
        sliderImages!.add(new SliderImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['content_ar'] = this.contentAr;
    data['content_en'] = this.contentEn;
    data['button_text_ar'] = this.buttonTextAr;
    data['button_text_en'] = this.buttonTextEn;
    if (this.sliderImages != null) {
      data['slider_images'] =
          this.sliderImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderImages {
  String? imgPath;

  SliderImages({this.imgPath});

  SliderImages.fromJson(Map<String, dynamic> json) {
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_path'] = this.imgPath;
    return data;
  }
}

class Offers {
  int? id;
  String? imgPath;
  String? value;
  String? valueType;
  String? type;
  String? start;
  String? end;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Companies>? companies;

  Offers(
      {this.id,
        this.imgPath,
        this.value,
        this.valueType,
        this.type,
        this.start,
        this.end,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.companies});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgPath = json['img_path'];
    value = json['value'];
    valueType = json['value_type'];
    type = json['type'];
    start = json['start'];
    end = json['end'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(new Companies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img_path'] = this.imgPath;
    data['value'] = this.value;
    data['value_type'] = this.valueType;
    data['type'] = this.type;
    data['start'] = this.start;
    data['end'] = this.end;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companies {
  int? userId;
  String? nameAr;
  String? nameEn;
  int? ordersPerHour;
  String? logoPath;
  Null? deletedAt;
  int? countryId;

  Companies(
      {this.userId,
        this.nameAr,
        this.nameEn,
        this.ordersPerHour,
        this.logoPath,
        this.deletedAt,
        this.countryId});

  Companies.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    ordersPerHour = json['orders_per_hour'];
    logoPath = json['logo_path'];
    deletedAt = json['deleted_at'];
    countryId = json['country_id'];
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
    return data;
  }
}
