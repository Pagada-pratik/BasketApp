class CartItemsModel {
  final String itemKey;
  final int productId;
  final String vendorId;
  final String storeName;
  final String vendorName;
  final String name;
  final double price;
  final int quantity;
  final int minPurchase;
  final int maxPurchase;
  final String sku;
  final String imgUrl;

  CartItemsModel({
    required this.itemKey,
    required this.productId,
    required this.vendorId,
    required this.storeName,
    required this.vendorName,
    required this.name,
    required this.price,
    required this.quantity,
    required this.minPurchase,
    required this.maxPurchase,
    required this.sku,
    required this.imgUrl,
  });
}