class OrderModel {
  int id;
  int parentId;
  String status;
  String currency;
  String discountTotal;
  String total;
  String currencySymbol;
  String orderKey;
  String paymentMethodTitle;
  Billing billing;
  List<LineItem> lineItems;
  List<Store> store;

  OrderModel({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.discountTotal,
    required this.total,
    required this.currencySymbol,
    required this.orderKey,
    required this.paymentMethodTitle,
    required this.billing,
    required this.lineItems,
    required this.store,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      parentId: json['parent_id'],
      status: json['status'],
      currency: json['currency'],
      discountTotal: json['discount_total'],
      total: json['total'],
      currencySymbol: json['currency_symbol'],
      orderKey: json['order_key'] ?? '',
      paymentMethodTitle: json['payment_method_title'] ?? '',
      billing: Billing.fromJson(json['billing']),
      lineItems: (json['line_items'] as List)
          .map((item) => LineItem.fromJson(item))
          .toList(),
      store: (json['stores'] as List)
          .map((item) => Store.fromJson(item))
          .toList(),
    );
  }
}

class Billing {
  String firstName;
  String lastName;
  String address1;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      firstName: json['first_name'],
      lastName: json['last_name'],
      address1: json['address_1'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class LineItem {
  int id;
  int productId;
  String name;
  int quantity;
  String subtotal;
  String total;
  String? sku;

  LineItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.subtotal,
    required this.total,
    this.sku,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      total: json['total'],
      sku: json['sku'],
    );
  }
}

class Store {
  int id;
  String shopName;

  Store({
    required this.id,
    required this.shopName,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      shopName: json['shop_name'],
    );
  }
}