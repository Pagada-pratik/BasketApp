import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/components/custom_modal_bottom_sheet.dart';
import 'package:mybasket247/views/checkout/components/remove_to_cart.dart';

import '../../controllers/cart/product_cart_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/product_guest_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../views/checkout/components/cart_product_quantity.dart';
import '../network_image_with_loader.dart';

class SecondaryProductCard extends StatelessWidget {
  const SecondaryProductCard({
    super.key,
    required this.itemKey,
    required this.image,
    required this.brandName,
    required this.title,
    required this.productId,
    required this.quantity,
    required this.minPurchase,
    required this.maxPurchase,
    required this.price,
    this.priceAfetDiscount,
    this.discountPercent,
    this.press,
    this.style,
    this.isOrderConfirm,
  });

  final String itemKey;
  final String image, brandName, title;
  final int productId, quantity, minPurchase, maxPurchase;
  final double price;
  final double? priceAfetDiscount;
  final int? discountPercent;
  final VoidCallback? press;
  final ButtonStyle? style;
  final bool? isOrderConfirm;

  @override
  Widget build(BuildContext context) {
    ProductCartController productCartController = Get.put(ProductCartController());
    ProfileController profileController = Get.put(ProfileController());
    UserController userController = Get.put(UserController());

    RxInt cartQuantityCount = quantity.obs;
    return OutlinedButton(
      onPressed: press,
      style: style ??
          OutlinedButton.styleFrom(
              minimumSize: const Size(256, 114),
              maximumSize: const Size(256, 114),
              padding: const EdgeInsets.all(8)),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(image,
                    radius: AppConstants.defaultBorderRadius),
                if (discountPercent != null)
                  Positioned(
                    right: AppConstants.defaultPadding / 2,
                    top: AppConstants.defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConstants.defaultBorderRadius)),
                      ),
                      child: Text(
                        "$discountPercent% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding / 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: AppConstants.defaultPadding / 2),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      priceAfetDiscount != null
                          ? Row(
                              children: [
                                Text(
                                  "€$priceAfetDiscount",
                                  style: const TextStyle(
                                    color: AppColors.primaryAppColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                    width: AppConstants.defaultPadding / 4),
                                Text(
                                  "€$price",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "€$price",
                              style: const TextStyle(
                                color: AppColors.primaryAppColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                      if (!isOrderConfirm!)
                        Obx(() => CartProductQuantity(
                              numOfItem: cartQuantityCount.value,
                              onIncrement: () async {
                                if (cartQuantityCount.value < maxPurchase) {
                                  if(profileController.userId.isNotEmpty ) {
                                    cartQuantityCount.value++;

                                    await productCartController
                                        .updateProductInCartApiResponse(
                                        itemKey,
                                        cartQuantityCount.value.toString(),
                                        context);
                                  } else {
                                    cartQuantityCount.value++;
                                    await userController.addProductToList(ProductGuestModel(id: productId.toString(), quantity: 1));
                                    await productCartController.getGuestProductDataApiResponse(context);
                                  }
                                }
                              },
                              onDecrement: () async {
                                if (cartQuantityCount.value != 1) {
                                  if(profileController.userId.isNotEmpty ) {
                                    cartQuantityCount.value--;
                                    await productCartController
                                        .updateProductInCartApiResponse(
                                        itemKey,
                                        cartQuantityCount.value.toString(),
                                        context);
                                  } else {
                                    cartQuantityCount.value--;
                                    await userController.removeProductFromList(ProductGuestModel(id: productId.toString(), quantity: 1));
                                    await productCartController.getGuestProductDataApiResponse(context);
                                  }
                                } else {
                                  customModalBottomSheet(
                                    context,
                                    isDismissible: true,
                                    height: Get.height * 0.15,
                                    child: RemoveToCart(itemKey: itemKey, productId: productId, userIdFlag: profileController.userId.isNotEmpty),
                                  );
                                }
                              },
                            ))
                      else
                        Text(
                          'x $quantity Quantity',
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
