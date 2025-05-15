import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../controllers/categories/order_payments_controller.dart';

class PaymentGatewayServices {
  OrderPaymentsController orderPaymentsController =
      Get.put(OrderPaymentsController());

  final String username =
      'yynqqno0swx56q2nukr2ei21t6dy149v5qo8wpwso01k0.apps.vivapayments.com';
  final String password = 'h3e1sc99A7rm3uK08qAWhX9sHTbi2M';

  String? _accessToken;

  // Method to get Access Token
  Future<void> getAccessToken() async {
    String url = 'https://demo-accounts.vivapayments.com/connect/token';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$username:$password')),
        },
        body: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        _accessToken = jsonData['access_token'];
        print('Access Token: $_accessToken');
      } else {
        print('Failed to get Access Token: ${response.body}');
      }
    } catch (e) {
      print('Error getting Access Token: $e');
    }
  }

  // Method to Create Order
  Future<String?> createOrder(double amount) async {
    String url = 'https://demo-api.vivapayments.com/checkout/v2/orders';

    if (_accessToken == null) {
      print('Access Token is null. Please authenticate first.');
      return null;
    }

    try {
      int amountInCents = (amount * 100).toInt(); // Convert to minor units
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
        body: jsonEncode({
          'amount': amountInCents,
          'customerTrns': 'Product Payment',
          'successUrl': 'myapp://payment-success',
          'failureUrl': 'myapp://payment-fail',
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        int orderCode = jsonData['orderCode'];
        print('Order Code: $orderCode');
        return orderCode.toString();
      } else {
        print('Failed to create Order: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating Order: $e');
      return null;
    }
  }

  // Method to get Smart Checkout URL
  String getCheckoutUrl(String orderCode) {
    return 'https://demo.vivapayments.com/web/checkout?ref=$orderCode';
  }

  // Method to launch URL
  /*Future<void> launchCheckoutUrl(String orderCode, BuildContext context) async {
    String url = getCheckoutUrl(orderCode);
    if (await canLaunch(url)) {
      await launch(url);

      // Listen for deep link callbacks
      Uri? deepLink = await getDeepLink();
      if (deepLink != null) {
        if (deepLink.toString().contains('payment-success')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Successful')),
          );
          orderPaymentsController.createOrderApiResponse(
            setPaid: true,
            context: context,
          );
        } else if (deepLink.toString().contains('payment-failure')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Failed')),
          );
          orderPaymentsController.createOrderApiResponse(
            setPaid: false,
            context: context,
          );
        }
      }
    } else {
      throw 'Could not launch $url';
    }
  }*/

  // Simulate deep link callback
  // Future<Uri?> getDeepLink() async {
  //   await Future.delayed(
  //       const Duration(seconds: 10)); // Simulate waiting for deep link
  //   return null; // Replace this with actual deep link handling
  // }
}
