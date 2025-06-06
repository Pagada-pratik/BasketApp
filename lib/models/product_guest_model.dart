class ProductGuestModel {
  final String id;
  final int quantity;

  ProductGuestModel({required this.id, required this.quantity});

  factory ProductGuestModel.fromJson(Map<String, dynamic> json) {
    return ProductGuestModel(
      id: json['id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}