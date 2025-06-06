import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/user_controller.dart';
import '../../../controllers/cart/product_cart_controller.dart';
import '../../../models/product_guest_model.dart';
import '../../../resources/constants.dart';

class RemoveToCart extends StatelessWidget {
  final String itemKey;
  final int productId;
  final bool userIdFlag;
  const RemoveToCart({super.key, required this.itemKey, required int this.productId, required bool this.userIdFlag});

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
                  if(userIdFlag) {
                    await productCartController
                        .removeProductFromCartApiResponse(itemKey, context);
                  } else {
                    await UserController().removeProductFromList(ProductGuestModel(id: productId.toString(), quantity: 1));
                    Navigator.pop(context);
                    await productCartController.getGuestProductDataApiResponse(context);
                  }
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