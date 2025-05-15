// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/product/secondary_product_card.dart';
import '../../../components/skeleton/product/secondary_products_skeleton.dart';
import '../../../models/cart_model.dart';
import '../../../resources/constants.dart';
import 'remove_to_cart.dart';

class CartProduct extends StatelessWidget {
  final List<CartItemsModel> getCartItems;
  final bool isOrderConfirm;

  const CartProduct(
      {super.key, required this.getCartItems, required this.isOrderConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            (!isOrderConfirm) ? "Review your order" : "Product",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Obx(() => (getCartItems.isNotEmpty)
            ? SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getCartItems.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      left: AppConstants.defaultPadding,
                      right: AppConstants.defaultPadding,
                      bottom: AppConstants.defaultPadding,
                    ),
                    child: SecondaryProductCard(
                      itemKey: getCartItems[index].itemKey,
                      image: getCartItems[index].imgUrl,
                      brandName: getCartItems[index].sku,
                      title: getCartItems[index].name,
                      productId: getCartItems[index].productId,
                      quantity: getCartItems[index].quantity,
                      minPurchase: getCartItems[index].minPurchase,
                      maxPurchase: getCartItems[index].maxPurchase,
                      price: getCartItems[index].price,
                      isOrderConfirm: isOrderConfirm,
                      press: () {},
                      // priceAfetDiscount: getCartItems[index].priceAfetDiscount,
                      // discountPercent: getCartItems[index].discountPercent,
                      // press: () async {
                      //   (!isOrderConfirm) ?
                      //   customModalBottomSheet(
                      //     context,
                      //     isDismissible: true,
                      //     height: Get.height * 0.15,
                      //     child: RemoveToCart(itemKey: getCartItems[index].itemKey),
                      //   ) : null;
                    ),
                  ),
                ),
              )
            : const SecondaryProductsSkeleton()),
      ],
    );
  }
}
