class OrderModel {
  int id;
  String status;
  String currency;
  String total;
  String orderKey;
  String paymentMethodTitle;
  Billing billing;
  List<LineItem> lineItems;

  OrderModel({
    required this.id,
    required this.status,
    required this.currency,
    required this.total,
    required this.orderKey,
    required this.paymentMethodTitle,
    required this.billing,
    required this.lineItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      currency: json['currency'],
      total: json['total'],
      orderKey: json['order_key'] ?? '',
      paymentMethodTitle: json['payment_method_title'] ?? '',
      billing: Billing.fromJson(json['billing']),
      lineItems: (json['line_items'] as List)
          .map((item) => LineItem.fromJson(item))
          .toList(),
    );
  }
}

class Billing {
  String firstName;
  String lastName;
  String address1;
  String email;
  String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      firstName: json['first_name'],
      lastName: json['last_name'],
      address1: json['address_1'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class LineItem {
  int id;
  String name;
  int quantity;
  String total;
  String? sku;

  LineItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.total,
    this.sku,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      total: json['total'],
      sku: json['sku'],
    );
  }
}