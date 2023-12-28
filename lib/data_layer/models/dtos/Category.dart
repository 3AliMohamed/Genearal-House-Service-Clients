class Category {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  int? haveSubCategories;

  Category(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.imgPath,
        this.haveSubCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    haveSubCategories = json['have_sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    data['have_sub_categories'] = this.haveSubCategories;
    return data;
  }
}