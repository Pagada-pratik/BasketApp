import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/product/product_card.dart';
import '../../../components/banner/M/banner_m_with_counter.dart';
import '../../../components/skeleton/banner/banner_m_counter_skeleton.dart';
import '../../../components/skeleton/product/products_skeleton.dart';
import '../../../controllers/home/on_sale_controller.dart';
import '../../../resources/constants.dart';
import '../../../routes/routes_name.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({super.key});

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  OnSaleController onSaleController = Get.put(OnSaleController());

  @override
  void initState() {
    super.initState();
    onSaleController.onSaleBannerApiResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => (onSaleController.onSaleBannerUrl.isNotEmpty) ?
        BannerMWithCounter(
          image: onSaleController.onSaleBannerUrl.value,
          duration: const Duration(hours: 12),
          text: "Deals Of The Day\nEnds in",
          press: () {},
        ) : const BannerMWithCounterSkeleton()),
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Deals Of The Day",
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
        Obx(() => (onSaleController.onSaleProducts.isNotEmpty) ?
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: onSaleController.onSaleProducts.length,
            // itemCount: onSaleController.onSaleProducts.length > 5
            //     ? 5
            //     : onSaleController.onSaleProducts.length,
            itemBuilder: (context, index) {
              // int itemCount = onSaleController.onSaleProducts.length > 5
              //     ? 5
              //     : onSaleController.onSaleProducts.length;

              final productData = onSaleController.onSaleProducts[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: AppConstants.defaultPadding,
                  right: index == onSaleController.onSaleProducts.length - 1 ? AppConstants.defaultPadding : 0,
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
        ) : const ProductsSkeleton()),
      ],
    );
  }
}