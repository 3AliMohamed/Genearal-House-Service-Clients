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
  NavbarFooter? navbarFooter;

  HomePageData({this.homePage, this.navbarFooter});

  HomePageData.fromJson(Map<String, dynamic> json) {
    homePage = json['home_page'] != null
        ? new HomePage.fromJson(json['home_page'])
        : null;
    navbarFooter = json['navbar_footer'] != null
        ? new NavbarFooter.fromJson(json['navbar_footer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homePage != null) {
      data['home_page'] = this.homePage!.toJson();
    }
    if (this.navbarFooter != null) {
      data['navbar_footer'] = this.navbarFooter!.toJson();
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

  HomePage(
      {this.id,
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

class NavbarFooter {
  int? id;
  String? whatsappNumber;
  String? phoneNumber;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? footerTitleAr;
  String? footerTitleEn;
  String? footerContentAr;
  String? footerContentEn;

  NavbarFooter(
      {this.id,
        this.whatsappNumber,
        this.phoneNumber,
        this.facebookLink,
        this.instagramLink,
        this.twitterLink,
        this.footerTitleAr,
        this.footerTitleEn,
        this.footerContentAr,
        this.footerContentEn});

  NavbarFooter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    footerTitleAr = json['footer_title_ar'];
    footerTitleEn = json['footer_title_en'];
    footerContentAr = json['footer_content_ar'];
    footerContentEn = json['footer_content_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['whatsapp_number'] = this.whatsappNumber;
    data['phone_number'] = this.phoneNumber;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['footer_title_ar'] = this.footerTitleAr;
    data['footer_title_en'] = this.footerTitleEn;
    data['footer_content_ar'] = this.footerContentAr;
    data['footer_content_en'] = this.footerContentEn;
    return data;
  }
}
