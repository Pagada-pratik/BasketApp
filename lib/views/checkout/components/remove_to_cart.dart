import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cart/product_cart_controller.dart';
import '../../../resources/constants.dart';

class RemoveToCart extends StatelessWidget {
  final String itemKey;
  const RemoveToCart({super.key, required this.itemKey});

  @override
  Widget build(BuildContext context) {
    ProductCartController productCartController = Get.put(ProductCartController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await productCartController.removeProductFromCartApiResponse(itemKey, context);
                },
                child: const Text("Remove from cart"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}