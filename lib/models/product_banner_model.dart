class ProductBannerModel {
  String? acfFcLayout;
  String? bannerImage;
  String? bannerTitle;
  String? bannerSubTitle;
  String? bannerButtonText;
  List<int>? productCategory;

  ProductBannerModel(
      {this.acfFcLayout,
        this.bannerImage,
        this.bannerTitle,
        this.bannerSubTitle,
        this.bannerButtonText,
        this.productCategory});

  ProductBannerModel.fromJson(Map<String, dynamic> json) {
    acfFcLayout = json['acf_fc_layout'];
    bannerImage = json['banner_image'];
    bannerTitle = json['banner_title'];
    bannerSubTitle = json['banner_sub_title'];
    bannerButtonText = json['banner_button_text'];
    productCategory = (json['product_category'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acf_fc_layout'] = acfFcLayout;
    data['banner_image'] = bannerImage;
    data['banner_title'] = bannerTitle;
    data['banner_sub_title'] = bannerSubTitle;
    data['banner_button_text'] = bannerButtonText;
    data['product_category'] = productCategory;
    return data;
  }
}