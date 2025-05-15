import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product/product_card.dart';
import '../../../components/skeleton/product/products_skeleton.dart';
import '../../../controllers/home/section_products_controller.dart';
import '../../../resources/constants.dart';
import '../../../routes/routes_name.dart';

class BestSellers extends StatefulWidget {
  final String title;
  final int productCategoryId;
  const BestSellers(this.title, this.productCategoryId, {super.key});

  @override
  State<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers> {
  SectionProductsController sectionProductsController = Get.put(SectionProductsController());

  @override
  void initState() {
    super.initState();
    sectionProductsController.sectionBaseHomeProductsApiResponse(context, widget.productCategoryId);
  }

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
                widget.title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text("See All"),
              // ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Obx(() {
          final products = sectionProductsController.categoryProducts[widget.productCategoryId];
          if (products == null || products.isEmpty) {
            return const ProductsSkeleton();
          }

          return SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              // itemCount: products.length > 5 ? 5 : products.length,
              itemBuilder: (context, index) {
                // int itemCount = products.length > 5 ? 5 : products.length;
                return Padding(
                  padding: EdgeInsets.only(
                    left: AppConstants.defaultPadding,
                    right: index == products.length - 1 ? AppConstants.defaultPadding : 0,
                    // right: index == itemCount - 1 ? AppConstants.defaultPadding : 0,
                  ),
                  child: ProductCard(
                    image: products[index].image,
                    brandName: products[index].brandName,
                    title: products[index].title,
                    price: products[index].price,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.productDetailsScreen,
                        arguments: {
                          'productId': products[index].productId,
                          'categoryId': products[index].categoryId,
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}