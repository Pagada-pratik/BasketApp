import '../resources/constants.dart';

class ProductModel {
  final int? productId;
  final int categoryId;
  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? discountPercent;

  ProductModel({
    this.productId,
    required this.categoryId,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.discountPercent,
  });
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    categoryId: 0,
    image: AppConstants.productDemoImg1,
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfetDiscount: 420,
    discountPercent: 20,
  ),
  ProductModel(
    categoryId: 0,
    image: AppConstants.productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    categoryId: 0,
    image: AppConstants.productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    discountPercent: 40,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    discountPercent: 40,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    discountPercent: 5,
  ),
  ProductModel(
    categoryId: 0,
    image: AppConstants.productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    discountPercent: 15,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 590.36,
    discountPercent: 24,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Pont-Knit Sheath ",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfetDiscount: 360,
    discountPercent: 20,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    categoryId: 0,
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];