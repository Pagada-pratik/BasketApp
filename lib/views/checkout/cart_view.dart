import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/profile_controller.dart';

import '../../controllers/cart/product_cart_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import 'components/cart_product.dart';
import 'components/checkout_product.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  ProductCartController productCartController =
      Get.put(ProductCartController());
  ProfileController profileController =
      Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    print("Cart View--");
    print(profileController.userId);
    productCartController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    if(profileController.userId.isNotEmpty ) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        productCartController.isCartEmpty.value = true;
        await productCartController.getCartForUserApiResponse(context);
      });
    } else{
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        productCartController.isCartEmpty.value = true;
        await productCartController.getGuestProductDataApiResponse(context);
      });
    }
  }

  @override
  void dispose() {
    productCartController.isCartEmpty.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          log('message ${!productCartController.isCartEmpty.value}');
          return (!productCartController.isCartEmpty.value)
              ? CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: CartProduct(
                            getCartItems: productCartController.getCartData,
                            isOrderConfirm: false)),
                    const SliverToBoxAdapter(
                        child: CheckoutProduct(isOrderConfirm: false)),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppConstants.defaultPadding,
                          right: AppConstants.defaultPadding,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppConstants.defaultPadding * 2),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.checkoutProcessScreen);
                              },
                              child: const Text(
                                "Proceed to checkout",
                                style: TextStyle(
                                    fontSize: AppConstants.defaultFontSize),
                              ),
                            ),
                            const SizedBox(height: AppConstants.defaultPadding),
                            OutlinedButton(
                              onPressed: () {
                                if(profileController.userId.isNotEmpty) {
                                  if (productCartController.getCartData
                                      .isNotEmpty) {
                                    productCartController.clearCartApiResponse(
                                        context);
                                  }
                                } else{
                                  productCartController.getGuestProductDataClear(context);
                                }
                              },
                              child: const Text("Clear cart",
                                  style:
                                      TextStyle(color: AppColors.blackColor)),
                            ),
                            const SizedBox(height: AppConstants.defaultPadding),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/Illustration/Illustration-1.png"
                            : "assets/Illustration/Illustration_darkTheme_1.png",
                        height: MediaQuery.of(context).size.height * 0.26,
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Text(
                        "No items on the cart!",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
