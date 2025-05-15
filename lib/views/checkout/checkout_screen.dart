import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/categories/order_payments_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class CheckoutScreen extends StatefulWidget {
  final String orderCode;

  const CheckoutScreen({required this.orderCode, super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late WebViewController controller;
  OrderPaymentsController orderPaymentsController =
      Get.put(OrderPaymentsController());

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("success")) {
              // Handle success
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Successful')),
              );
              orderPaymentsController.createOrderApiResponse(
                setPaid: true,
                context: context,
              );
              print("Payment Success Detected");
              // Navigate or update state
            } else if (request.url.contains("fail")) {
              // Handle failure
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Failed')),
              );
              orderPaymentsController.createOrderApiResponse(
                setPaid: false,
                context: context,
              );
              print("Payment Failure Detected");
              // Navigate or update state
            }

            log('payment ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://demo.vivapayments.com/web/checkout?ref=${widget.orderCode}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 80,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("Payment"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
