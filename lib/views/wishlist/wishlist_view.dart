// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/product/product_card.dart';
import '../../components/skeleton/product/wishlist_skeleton.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  ProfileController profileController = Get.put(ProfileController());
  WishlistController wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await wishlistController.getWishlistApiResponse(context, profileController.userId.toString());
    });
  }

  @override
  void dispose() {
    wishlistController.isWishlistEmpty.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => (!wishlistController.isWishlistEmpty.value) ?
      CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding),
            sliver: Obx(() => wishlistController.wishlistAllProducts.isNotEmpty ?
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: AppConstants.defaultPadding,
                crossAxisSpacing: AppConstants.defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                final wishlistData = wishlistController.wishlistAllProducts[index];
                return ProductCard(
                  image: wishlistData.image,
                  brandName: wishlistData.brandName,
                  title: wishlistData.title,
                  price: wishlistData.price,
                  priceAfetDiscount: wishlistData.priceAfetDiscount,
                  discountPercent: wishlistData.discountPercent,
                  press: () async {
                    await Navigator.pushNamed(
                      context,
                      RoutesName.productDetailsScreen,
                      arguments: {
                        'productId': wishlistData.productId,
                        'categoryId': wishlistData.categoryId,
                      },
                    );
                    await wishlistController.getWishlistApiResponse(context, profileController.userId.toString());
                  },
                );
              },
                childCount: wishlistController.wishlistAllProducts.length,
              ),
            ) : const WishlistSkeleton()),
          ),
        ],
      ) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? "assets/Illustration/EmptyState_lightTheme.png"
                  : "assets/Illustration/EmptyState_darkTheme.png",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Text(
              "No items on the wishlist!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      )),
    );
  }
}