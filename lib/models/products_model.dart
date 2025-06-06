class ProductsModel {
  int id;
  String name;
  String price;
  String sku;
  String stockStatus;
  String weight;
  Dimensions dimensions;
  List<Images> images;

  ProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.sku,
    required this.stockStatus,
    required this.weight,
    required this.dimensions,
    required this.images,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      sku: json['sku'],
      stockStatus: json['stock_status'],
      weight: json['weight'],
      dimensions: Dimensions.fromJson(json['dimensions']),
      images: (json['images'] as List)
          .map((item) => Images.fromJson(item))
          .toList(),
    );
  }
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      length: json['length'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class Images {
  int id;
  String src;

  Images({
    required this.id,
    required this.src,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      src: json['src'],
    );
  }
}