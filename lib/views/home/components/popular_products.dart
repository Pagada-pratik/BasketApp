import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product/product_card.dart';
import '../../../components/skeleton/product/products_skeleton.dart';
import '../../../controllers/home/categories_products_controller.dart';
import '../../../resources/constants.dart';
import '../../../routes/routes_name.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  HomeCategoriesProductsController homeCategoriesProductsController = Get.put(HomeCategoriesProductsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Popular Products from Categories",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text("See All"),
              // ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding / 2.5),
        Obx(() => (homeCategoriesProductsController.categoriesBasePopularProducts.isNotEmpty) ?
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeCategoriesProductsController.categoriesBasePopularProducts.length,
            // itemCount: homeCategoriesProductsController.categoriesBasePopularProducts.length > 5
            //     ? 5
            //     : homeCategoriesProductsController.categoriesBasePopularProducts.length,
            itemBuilder: (context, index) {
              // int itemCount = homeCategoriesProductsController.categoriesBasePopularProducts.length > 5
              //     ? 5
              //     : homeCategoriesProductsController.categoriesBasePopularProducts.length;

              final productData = homeCategoriesProductsController.categoriesBasePopularProducts[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: AppConstants.defaultPadding,
                  right: index == homeCategoriesProductsController.categoriesBasePopularProducts.length - 1 ? AppConstants.defaultPadding : 0,
                  // right: index == itemCount - 1 ? AppConstants.defaultPadding : 0,
                ),
                child: ProductCard(
                  image: productData.image,
                  brandName: productData.brandName,
                  title: productData.title,
                  price: productData.price,
                  priceAfetDiscount: productData.priceAfetDiscount,
                  discountPercent: productData.discountPercent,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.productDetailsScreen,
                      arguments: {
                        'productId': productData.productId,
                        'categoryId': productData.categoryId,
                      },
                    );
                  },
                ),
              );
            },
          ),
        ) : (!homeCategoriesProductsController.isProductNotFound.value)
            ? const ProductsSkeleton()
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/NoResult.png"
                    : "assets/Illustration/NoResultDarkTheme.png",
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "Product not found",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        )),
      ],
    );
  }
}